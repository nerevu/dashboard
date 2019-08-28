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
    @sales_rep = metric["Sales Rep"].toLowerCase().split(" ")
      .map (name) -> "#{name[0].toUpperCase()}#{name[1..]}"
      .join " "
    @errors = metric.Errors
