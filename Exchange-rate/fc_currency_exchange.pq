// ============================================================
// FUNCTION FOR CURRENCY EXCHANGE RATES (OLINDA/BCB API)
// ============================================================

let
    Source = OData.Feed(
        "https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/",
        null,
        [Implementation = "2.0"]
    ),
    #"fc_CurrencyExchange (moeda as text, dataInicial as text, dataFinalCotacao as text) as table" =
        Source{
            [
                Name = "CotacaoMoedaPeriodo",
                Signature = "function (moeda as text, dataInicial as text, dataFinalCotacao as text) as table"
            ]
        }[Data]
in
    #"fc_CurrencyExchange (moeda as text, dataInicial as text, dataFinalCotacao as text) as table"
