# Layout

A starting point. Setup creates only the groups the person chose. `FOLDERS.txt`
decides what is open or private; this page only describes it.

```
inbox/                private; quick notes, sorted later
personal/
  projects/
  finances/           private
  health/             private
  home/
  logs/
business/             optional
  <company-name>/     one per company
    clients/          private
    contracts/        private, notes only
    finances/         private, notes only
    projects/
    logs/
school/               optional
  <course-name>/
job/                  optional; your own career notes, not employer files
  career/
  logs/
documents/            private, all of it
  _unsorted/
  personal/           finances, taxes, health, home
  business/
    <company-name>/   contracts, invoices, taxes, legal
  school/             optional
  job/                optional
templates/
graphify-out/         made by Graphify; never edited by hand
```

## Names

Lowercase with hyphens. Two or three folder levels are enough.

| Kind | Pattern | Example |
|---|---|---|
| Note | `topic.md` | `tax-planning.md` |
| Log | `date-topic.md` | `2026-05-01-tax-planning.md` |
| Document | `date-who-what-detail.ext` | `2026-04-12-acme-contract-website-signed.pdf` |
| Yearly form | `year-who-what.ext` | `2025-example-employer-w2.pdf` |

- Use the document's own date.
- Mark state with `draft-v2`, `signed` or `paid`.
- Keep ID numbers, account numbers and medical details out of names.
- Give an important document a short note that links to it; qmd reads Markdown only.
