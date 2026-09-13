let
    Source = DateTimeZone.SwitchZone(DateTimeZone.From(DateTime.LocalNow()), 0), //Edit the 0 to match your time zone
    #"Converted to Table" = #table(1, {{Source}}),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "#LastUpdate"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"#LastUpdate", type datetime}})
in
    #"Changed Type"
