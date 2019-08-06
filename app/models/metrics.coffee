Collection = require './base/collection'
Metric = require './metric'

module.exports = class Metrics extends Collection
  constructor: ->
    super Metric, 'metrics'

    @visible =
      xs: ['invoice_number', 'amount']
      sm: ['invoice_number', 'amount', 'commission', 'sales_rep']
      md: ['invoice_number', 'amount', 'commission', 'invoice_date', 'sales_rep']
      lg: [
        'invoice_number', 'contract_number', 'po_numbers', 'amount', 'commission',
        'invoice_date', 'sales_rep'
      ]
      xl: [
        'invoice_number', 'contract_number', 'po_numbers', 'amount', 'commission',
        'invoice_date', 'invoice_period', 'sales_rep', 'errors'
      ]
