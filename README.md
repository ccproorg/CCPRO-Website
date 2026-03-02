# CCPRO Website

**Community College Planning and Research Organization**

A Quarto-based website for CCPRO, a professional organization supporting institutional research, institutional effectiveness, and assessment professionals across North Carolina's community college system.

## Site Structure

| Page | Description |
|------|-------------|
| Home | About Us / mission overview / FAQ |
| Regions | Regional breakdown of NC community colleges |
| Resources | Curated links for IR/IE professionals |
| Documents | Organizational document repository |
| Conferences/Meetings | Upcoming and past events |
| Membership Directory| Searchable directory for CCPRO members|
| Executive Committee | Current and past officer listings |
<!-- | Post A Job | Job board for community college IR/IE positions | Not currently being used-->

## Tech Stack

- [Quarto](https://quarto.org/) — static site generator
- Cosmo Bootstrap theme with `_brand.yml` for custom branding

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

- [x] Add CCPRO logo and branding assets to `images/` (Need to actually apply the logo)
- [x] Update `_brand.yml` with official colors, fonts, and logo
- [x] Populate officer, conference, and document content
- [ ] Upload organizational documents (bylaws, minutes, reports) and link them from `documents.qmd`
- [x] Embed a job posting form (Google Form / Microsoft Form) on the Post A Job page (Currently in Webmaster's one drive, could add to ccpro onedrive)
- [x] Set up deployment via GitHub Actions + Netlify (or similar hosting provider)
- [x] Add a `.gitignore` for `_site/` and `.quarto/`
- [ ] Get membership form to directly link with excel file pulling members for datatable on membership-directory.qmd.
