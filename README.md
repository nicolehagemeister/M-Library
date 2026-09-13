# DAX, M and Power Query Library
A personal collection of reusable functions and queries for Power BI, organized by use case.
The goal is to have a quick reference so the same logic doesn't need to be rewritten across different projects.

## Contents

| Folder | Description |

| [`paginated-api/`]([./Paginated-API]) | Generic function to consume a paginated API and combine all pages into a single table |

| [`exchange-rate/`]([./Exchange-rate]) | EUR/USD exchange rate via the Brazilian Central Bank API (Olinda/PTAX), with a fallback to a SharePoint backup |

| [`last-update/`]([./Last-Update]) | Query to generate a "Last Updated" card (date/time of the last refresh) |

| [`calendar/`]([./Calendar]) | Dynamic calendar (date) table, with year, month, and day columns |

## How to use

1. In Power BI, open the **Power Query Editor**.
2. Right-click the queries pane and choose **New Query > Blank Query**.
3. In the new query, click **Advanced Editor**.
4. Copy the contents of the desired file and paste it, replacing the default content.
5. Adjust the parameters marked with comments like `// ADD ...` or `//Change as needed` to fit your case.
6. Click **Done**, then **Close & Apply**.

## Before using in production

- Always replace the placeholders (such as `[ADD SOMETHING]`) with the real values for your environment.
- Review timeouts and pagination limits according to the API you're consuming.
- Test the queries with a small data volume before running them on a report with the full data load.

## License

Feel free to use, adapt, and share.
