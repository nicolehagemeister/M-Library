let
    // API SOURCE
    ApiSource =
        try
            let
                Source =
                    fc_currency_exchange(
                        "EUR",
                        "01-01-2018",
                        "12-31-2050"
                    ),

                RenamedColumns =
                    Table.RenameColumns(
                        Source,
                        {
                            {"cotacaoCompra", "Euro Buy"},
                            {"cotacaoVenda", "Euro Sell"}
                        },
                        MissingField.Ignore
                    ),

                ExchangeRateColumn =
                    if Table.HasColumns(RenamedColumns, "Euro Buy") then
                        "Euro Buy"
                    else if Table.HasColumns(RenamedColumns, "Euro Sell") then
                        "Euro Sell"
                    else
                        null,

                Result =
                    if ExchangeRateColumn <> null
                        and not Table.IsEmpty(RenamedColumns)
                    then
                        let
                            FixedDateTime =
                                Table.TransformColumns(
                                    RenamedColumns,
                                    {
                                        {
                                            "dataHoraCotacao",
                                            each
                                                try DateTime.From(_)
                                                otherwise DateTime.FromText(Text.From(_)),
                                            type datetime
                                        }
                                    }
                                ),

                            SortedRows =
                                Table.Sort(
                                    FixedDateTime,
                                    {{"dataHoraCotacao", Order.Descending}}
                                ),

                            LatestRow =
                                Table.FirstN(
                                    SortedRows,
                                    1
                                ),

                            SelectedColumns =
                                Table.SelectColumns(
                                    LatestRow,
                                    {
                                        "dataHoraCotacao",
                                        ExchangeRateColumn
                                    }
                                ),

                            RenamedResult =
                                Table.RenameColumns(
                                    SelectedColumns,
                                    {
                                        {"dataHoraCotacao", "Date"},
                                        {ExchangeRateColumn, "Euro"}
                                    }
                                ),

                            AddedYearMonth =
                                Table.AddColumn(
                                    RenamedResult,
                                    "YearMonth",
                                    each
                                        Date.Year(DateTime.Date([Date])) * 100 +
                                        Date.Month(DateTime.Date([Date])),
                                    Int64.Type
                                ),

                            ChangedType =
                                Table.TransformColumnTypes(
                                    AddedYearMonth,
                                    {{"Date", type date}}
                                )

                        in
                            ChangedType

                    else
                        #table(
                            type table[
                                Date = date,
                                Euro = number,
                                YearMonth = Int64.Type
                            ],
                            {}
                        )

            in
                Result,

    // BACKUP
    BackupSource =
        let
            Source = [BACKUP QUERY]
        in
            Source,

    // FINAL RESULT
    FinalResult =
        if ApiSource[HasError]
            or ApiSource[Value] = null
            or Table.IsEmpty(ApiSource[Value])
        then
            BackupSource
        else
            ApiSource[Value]

in
    FinalResult