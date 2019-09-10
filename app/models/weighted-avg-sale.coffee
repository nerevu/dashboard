module.exports = class WeightedAvgSale
  constructor: (metric, id) ->
    @invoice_period = metric["Invoice Period"]
    @sales_rep = metric["Sales Rep"]
    @sales_weight = metric["Sales Weight"]
    @total_sales = metric["Total Sales"]
    @total_upsells = metric["Total Upsells"]
    @upsell_weight = metric["Upsell Weight"]
    @weighted_avg_sales = metric["Weighted Average Sales"]
    @weighted_sales = metric["Weighted Sales"]
    @weighted_upsells = metric["Weighted Upsells"]