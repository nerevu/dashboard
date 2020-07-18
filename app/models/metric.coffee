module.exports = class Metric
  constructor: (metric, id) ->
    @id = metric.id or id
    @paid = metric.Paid
    @amount = parseFloat metric["Invoice Amount"]
    @profit = @amount * .72
    @commission = @profit * .1
    @invoiceDateObj = new Date metric["Invoice Date"]
    @invoiceDate = metric["Invoice Date"]
    @invoicePeriod = metric["Invoice Period"]
    @salesRep = metric["Sales Rep"]

