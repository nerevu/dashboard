Collection = require './base/collection'
Metric = require './metric'

module.exports = class Metrics extends Collection
  constructor: ->
    super Metric, 'metrics'

    @visible =
      xs: ['invoice_number', 'invoice_amount', 'sales_rep']
      sm: ['invoice_number', 'invoice_amount', 'commission', 'sales_rep']
      md: ['invoice_number', 'invoice_amount', 'profit', 'commission', 'sales_rep']
      lg: [
        'invoice_number', 'contract_number', 'po_numbers', 'invoice_amount', 'profit',
        'commission', 'invoice_date', 'sales_rep'
      ]
      xl: [
        'invoice_number', 'contract_number', 'po_numbers', 'invoice_amount', 'profit',
        'commission', 'invoice_date', 'invoice_period', 'sales_rep', 'errors'
      ]
