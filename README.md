# CCPRO Website

**Community College Planning and Research Organization**

A Quarto-based website for CCPRO, a professional organization supporting institutional research, institutional effectiveness, and assessment professionals across North Carolina's community college system.

## Site Structure

| Page | Description |
|------|-------------|
| Home | About Us / mission overview / FAQ |
| Regions | Regional breakdown of NC community colleges (with maps) |
| Resources | Curated links for IR/IE professionals |
| Documents | Organizational document repository (bylaws, history, minutes) |
| Conferences/Meetings | Upcoming and past events |
| Membership Directory | Searchable, downloadable directory for CCPRO members |
| Membership Form | Form to add a new member or edit current member information |
| Executive Committee | Current and past officer listings |

## Tech Stack

- [Quarto](https://quarto.org/) — static site generator
- [R](https://www.r-project.org/) — pre-render data processing for the membership directory
- Cosmo Bootstrap theme with `_brand.yml` for custom branding
- [GitHub](https://github.com/) — version control
- [Netlify](https://www.netlify.com/) — site hosting and domain management
- GitHub Actions — CI/CD for automated site deployment

## Pre-Render Pipeline

The membership directory is built from an Excel workbook (`documents/CCPRO_Membership_Database.xlsx`) with two sheets:

1. **New Membership** — base member records
2. **Edit Membership** — change requests that override base records

`_pre-render.r` reads both sheets, merges the latest edits per member, and saves the result as `code/directory.rds`, which is consumed by `pages/membership-directory.qmd` at render time.

## Getting Started

Preview the site locally:

```pwsh
quarto preview
```

Render the site:

```pwsh
quarto render
```

## TODO

- [x] Add CCPRO logo and branding assets to `images/`
- [x] Update `_brand.yml` with official colors, fonts, and logo
- [x] Populate officer, conference, and document content
- [x] Upload organizational documents (bylaws, minutes, reports)
- [x] Add membership form page
- [x] Set up deployment via GitHub Actions + Netlify
- [x] Add a `.gitignore` for `_site/` and `.quarto/`
- [x] Add pre-render script for membership directory
- [ ] Automate pre-render pipeline so the membership database is processed on every deploy
- [ ] Re-enable `_pre-render.r` (currently commented out) or integrate it into the CI workflow
