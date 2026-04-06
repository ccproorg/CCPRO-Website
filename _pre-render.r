library(dplyr) # Load dplyr for data manipulation
library(stringr) # Load stringr for string manipulation
library(DT) # Load DT for interactive tables
library(readxl) # Load readxl for reading Excel files
library(writexl)


new_members <- read_excel(
  "documents/CCPRO_Membership_Database.xlsx",
  sheet = "New Membership"
) |> # Read in the directory from Excel: CCPRO_Membership_Database.xlsx
  mutate(
    email = ifelse(
      !is.na(email) & email != "",
      str_glue('<a href="mailto:{email}">{email}</a>'),
      email
    )
  ) |>
  rename(
    member_name = current_member_name,
    title_new = title,
    region_new = region,
    college_new = college,
    email_new = email,
    college_phone_new = college_phone,
    sacscoc_liaison_new = sacscoc_liaison,
    executive_committee_member_new = executive_committee_member
  )

edit_members <- read_excel(
  "./documents/CCPRO_Membership_Database.xlsx",
  sheet = "Edit Membership"
) |> # Read in the directory from Excel: CCPRO_Membership_Database.xlsx
  mutate(
    email = ifelse(
      !is.na(email) & email != "",
      str_glue('<a href="mailto:{email}">{email}</a>'),
      email
    )
  ) |>
  rename(
    new_name = updated_name,
    title_edit = title,
    region_edit = region,
    college_edit = college,
    email_edit = email,
    college_phone_edit = college_phone,
    sacscoc_liaison_edit = sacscoc_liaison,
    executive_committee_member_edit = executive_committee_member
  )

latest_edits <- edit_members |>
  group_by(current_member_name) |>
  slice_max(order_by = date_submitted, n = 1, with_ties = FALSE) |>
  ungroup()

directory <- new_members |>
  left_join(
    latest_edits |> mutate(has_edit = TRUE),
    by = c("member_name" = "current_member_name")
  ) |>
  mutate(
    member_name = if_else(
      !is.na(has_edit) & !is.na(new_name),
      new_name,
      member_name
    ),
    title = if_else(!is.na(has_edit), title_edit, title_new),
    region = if_else(!is.na(has_edit), region_edit, region_new),
    college = if_else(!is.na(has_edit), college_edit, college_new),
    email = if_else(!is.na(has_edit), email_edit, email_new),
    college_phone = if_else(
      !is.na(has_edit),
      college_phone_edit,
      college_phone_new
    ),
    sacscoc_liaison = if_else(
      !is.na(has_edit),
      sacscoc_liaison_edit,
      sacscoc_liaison_new
    ),
    executive_committee_member = if_else(
      !is.na(has_edit),
      executive_committee_member_edit,
      executive_committee_member_new
    )
  ) |>
  select(
    member_name,
    title,
    region,
    college,
    email,
    college_phone,
    sacscoc_liaison,
    executive_committee_member
  )

if (file.exists("code/directory.rds")) {
  file.remove("code/directory.rds")
}

saveRDS(directory, "code/directory.rds")
