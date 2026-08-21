# build_geometry.R ------------------------------------------------------------
# Run this ONCE (or when Census boundaries change, which is roughly never for
# NC counties). Commit the resulting geojson to the repo.
#
# Do NOT let the Quarto site call tigris at render time -- it will fail your
# CI build the first time the Census API is slow or down. pages/regions.qmd
# reads the committed data/nc_counties.geojson; it does not source this file.
#
# Run from the project root: Rscript code/map.R

library(tigris)
library(sf)
library(dplyr)
library(rmapshaper)

options(tigris_use_cache = TRUE)

nc_raw <- counties(
  state = "NC",
  cb = TRUE, # generalized cartographic boundaries, much smaller
  resolution = "500k",
  year = 2023,
  class = "sf"
)

nc <- nc_raw |>
  transmute(
    geoid = GEOID,
    county = NAME
  ) |>
  st_transform(4326) # leaflet requires WGS84

# Simplify for web delivery. keep = 0.08 drops the file to a few hundred KB
# while leaving NC's county shapes clearly recognizable. Tune down if the page
# feels heavy, up if the coastal counties start looking wrong.
nc <- ms_simplify(nc, keep = 0.08, keep_shapes = TRUE)

dir.create("data", showWarnings = FALSE)
st_write(nc, "data/nc_counties.geojson", delete_dsn = TRUE, quiet = TRUE)

message(
  "Wrote data/nc_counties.geojson -- ",
  nrow(nc),
  " counties, ",
  round(file.size("data/nc_counties.geojson") / 1024),
  " KB"
)

# Sanity check: NC has 100 counties.
stopifnot(nrow(nc) == 100)
