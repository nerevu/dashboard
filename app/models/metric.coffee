module.exports = class Metric
  constructor: (metric, id) ->
    @id = metric.id or id
    @paid = metric.Paid
    @invoice_number = metric["Invoice Number"]
    @contract_number = metric["Contract Number"]
    @invoice_source = metric["Invoice Source"]
    @amount = parseFloat metric["Invoice Amount"]
    @cost_of_goods = parseFloat metric["Cost of Goods"]
    @profit = parseFloat metric.Profit
    @commission = parseFloat metric["Commission Due"]
    @invoice_date = new Date metric["Invoice Date"]
    @invoice_month_num = metric["Invoice Month Num"]
    @invoice_month = metric["Invoice Month"]
    @invoice_period = metric["Invoice Period"]
    @po_numbers = metric["PO Numbers"]
    @missing_pos = metric["Missing POs"]
    @sales_rep = metric["Sales Rep"]
    @errors = metric.Errors

    @sales_weight = metric["Sales Weight"]
    @upsell_weight = metric["Upsell Weight"]

    @period_sales = metric["Period Sales"]
    @period_upsells = metric["Period Upsells"]
    @period_weighted_average_sales = metric["Period Weighted Average Sales"]
    @period_weighted_sales = metric["Period Weighted Sales"]
    @period_weighted_upsells = metric["Period Weighted Upsells"]

    @rep_period_sales = metric["Rep Period Sales"]
    @rep_period_upsells = metric["Rep Period Upsells"]
    @rep_period_weighted_average_sales = metric["Rep Period Weighted Average Sales"]
    @rep_period_weighted_sales = metric["Rep Period Weighted Sales"]
    @rep_period_weighted_upsells = metric["Rep Period Weighted Upsells"]
