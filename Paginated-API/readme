# Function for Paginated APIs

Generic function that automatically walks through every page of a paginated REST API (using a `page` parameter) and combines the results into a single list/table.

## How to configure

Inside the function, edit:

- `BaseUrl` → the API's base URL (e.g. `"https://api.example.com"`)
- `RelativePath` → the endpoint path (e.g. `"v1/something"`)

The function assumes the API response is a JSON object containing a `"results"` field with the page's list of items. If your API uses a different field name (e.g. `"items"`), adjust this line:

```
if Fonte <> null and Record.HasFields(Fonte, "results")
then Fonte[results]
```



// SAMPLE QUERY THAT CONSUMES THE FUNCTION

let
    Source = fc_paginada()
in
    Source
