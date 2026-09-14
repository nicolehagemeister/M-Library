# EUR/USD Exchange Rate (Olinda/BCB API) with Backup

Function that queries the Brazilian Central Bank's PTAX service (via `olinda.bcb.gov.br`) for currency exchange rates, plus a sample query that:

1. Fetches the exchange rate for a given period.
2. Sorts the results and keeps only the single most recent quote in the period.
3. Falls back to a backup source (e.g. a table saved on SharePoint) if the API call fails.

## Files

- `fc_currency_exchange.pq` → the function that connects to the Central Bank API
- `query_exchange_rate.pq` → sample consumer query, with error handling and fallback to backup

## How to configure

In the sample query (`query_exchange_rate.pq`), adjust:

- `Currency` → `"EUR"` or `"USD"` or anything else
- `StartDate` / `EndDate` → the desired period, in `MM-DD-YYYY` format (this is the format the BCB API expects)
- `[BACKUP QUERY]` → replace with the actual query pointing to your backup source
