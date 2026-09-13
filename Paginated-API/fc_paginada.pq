() as table =>
let
    BaseUrl = [ADD BASE URL],

    // Function: search for a page (only raw data)
    GetPage = (Page as number) as list =>
        let
            Fonte =
                try
                    Json.Document(
                        Web.Contents(
                            BaseUrl,
                            [
                                RelativePath = [ADD RELATIVE PATH],
                                Query = [page = Text.From(Page)],
                                Timeout = #duration(0,0,30,0)
                            ]
                        )
                    )
                otherwise
                    null,
            
            Results =
                if Fonte <> null and Record.HasFields(Fonte, "results")
                then Fonte[results]
                else {}
        in
            Results,

    // Automatic pagination
    Pages =
        List.Generate(
            () => [Page = 1, Data = GetPage(1)],
            each List.Count([Data]) > 0,
            each [Page = [Page] + 1, Data = GetPage([Page] + 1)],
            each [Data]
        ),

    // Combine all pages
    AllResults = 
        if List.Count(Pages) = 0
        then {}
        else List.Combine(Pages),

    // Convert to table
    Convertido =
        Table.FromList(
            AllResults,
            Splitter.SplitByNothing(),
            null,
            null,
            ExtraValues.Error
        )
in
    Convertido
