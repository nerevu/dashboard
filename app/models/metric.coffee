module.exports = class Metric
  constructor: (metric, id) ->
    @id = metric.id or id
    @paid = metric.Paid
    @invoiceNumber = metric["Invoice Number"]
    @contractNumber = metric["Contract Number"]
    @invoiceSource = metric["Invoice Source"]
    @amount = parseFloat metric["Invoice Amount"]
    @costOfGoods = parseFloat metric["Cost of Goods"]
    @profit = parseFloat metric.Profit
    @commission = parseFloat metric["Commission Due"]
    @invoiceDateObj = new Date metric["Invoice Date"]
    @invoiceDate = metric["Invoice Date"]
    @invoiceMonthNum = metric["Invoice Month Num"]
    @invoiceMonth = metric["Invoice Month"]
    @invoicePeriod = metric["Invoice Period"]
    @poNumbers = metric["PO Numbers"]
    @missingPos = metric["Missing POs"]
    @salesRep = metric["Sales Rep"]
    @errors = metric.Errors

    @rating = metric["Rating"]
    @ratingWeight = metric["Rating Weight"]
    @interactionScore = metric["Interaction Score"]
    @interactionWeight = metric["Interaction Weight"]

    @salesWeight = metric["Sales Weight"]
    @upsellWeight = metric["Upsell Weight"]

    @periodSales = metric["Period Sales"]
    @periodUpsells = metric["Period Upsells"]
    @periodWeightedAverageSales = metric["Period Weighted Average Sales"]
    @periodWeightedSales = metric["Period Weighted Sales"]
    @periodWeightedUpsells = metric["Period Weighted Upsells"]

    @repPeriodSales = metric["Rep Period Sales"]
    @repPeriodUpsells = metric["Rep Period Upsells"]
    @repPeriodWeightedAverageSales = parseFloat(metric["Rep Period Weighted Average Sales"].toFixed 2)
    @repPeriodWeightedSales = metric["Rep Period Weighted Sales"]
    @repPeriodWeightedUpsells = metric["Rep Period Weighted Upsells"]
