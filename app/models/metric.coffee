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
    @total_sales = metric["Total Sales"]
    @total_upsells = metric["Total Upsells"]
    @upsell_weight = metric["Upsell Weight"]
    @weighted_avg_sales = metric["Weighted Average Sales"]
    @weighted_sales = metric["Weighted Sales"]
    @weighted_upsells = metric["Weighted Upsells"]
