let
    MinDate = #date(2019,1,1), //Chose your min date
    Today = Date.From(DateTime.LocalNow()),
    StartNextYear = Date.StartOfYear(Date.AddYears(Today, 1)), //Change to your max date based on today
    MaxDate = StartNextYear,
    Days = Duration.Days(MaxDate - MinDate)+1,
    ListDates = List.Dates(MinDate,Days,#duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(ListDates, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Added Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), Int64.Type),
    #"Added Month Name" = Table.AddColumn(#"Added Year", "Month name", each Date.MonthName([Date]), type text),
    #"Added Day" = Table.AddColumn(#"Added Month Name", "Day", each Date.Day([Date]), Int64.Type),
    #"Added Month" = Table.AddColumn(#"Added Day", "Month", each Date.Month([Date]), Int64.Type),
    #"Removed Duplicates" = Table.Distinct(#"Added Month", {"Date"})
in
    #"Removed Duplicates"
