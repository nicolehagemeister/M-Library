# Calendar (Date) Table

Generates a dynamic (dimension) calendar table, from a fixed `MinDate` up to the start of next calendar year, with year, month, day, and month name columns.

## How to configure

- `MinDate` → the table's fixed starting date (e.g. `#date(2019,1,1)`)
- `MaxDate` → by default, automatically calculated as the start of next year based on today's date; adjust if you need a fixed maximum date
