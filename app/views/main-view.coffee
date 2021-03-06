m = require 'mithril'
ChartHorizontal = require './components/chart-horizontal'
ChartVertical = require './components/chart-vertical'
StatBox = require './components/stat-box'
StatCard = require './components/stat-card'
InfoCard = require './components/info-card'

config = require 'config'
helpers = require 'lib/helpers'
author = config.author

module.exports = (vnode, attrs) ->
  ctrl = vnode.state.ctrl
  attrs = Object.assign attrs or {}, vnode.attrs
  site = config.site
  colors = config.site.colors
  rows = ctrl.metrics.list
  year = (new Date()).getFullYear()

  if ctrl.metrics.populated
    periods = ctrl.metrics.periods
    currentPeriod = periods[-1..]
    reps = ctrl.metrics.reps
    categories = ctrl.metrics.categories

    limitedCategories = categories.filter (c) -> c.id isnt 'periodWeightedAvgSales'
    statBoxData = limitedCategories.map (category) ->
      metric = ctrl.metrics[category.id]
      all = metric[currentPeriod].all

      {
        id: "statBox#{category.title}"
        color: category.color
        icon: category.icon
        title: "#{category.title} (#{currentPeriod})"
        value: all.valueText
        description: "#{all.difference.percentText} #{all.difference.direction} than last month"
        chartData: periods[-6..].map (period, pos) ->
          {x: pos, y: if metric[period] then metric[period].all.value else 0}
      }

    monthlyMetricsAttrs =
      pos: 0
      title: "Monthly Metrics"
      description: 'Sales, Profit, and Commissions Owed'
      chartData:
        labels: periods
        datasets: limitedCategories.map (category) ->
          metric = ctrl.metrics[category.id]

          {
            label: category.title
            data: periods.map (period) ->
              if metric[period] then metric[period].all.value else 0

            backgroundColor: category.backgroundColor
            borderWidth: 1
            fill: true
          }

    monthlyCommisionsAttrs =
      pos: 0
      title: "Monthly Commissions"
      description: 'Sales Rep Commissions'
      chartData:
        labels: periods
        datasets: reps.map (repName, pos) ->
          metric = ctrl.metrics.commission

          {
            label: repName
            data: periods.map (period) -> metric[period]?[repName]?.value or 0
            backgroundColor: colors.rep[pos].hex
            borderWidth: 1
            fill: true
          }

    infoCardsData = periods[-2..].map (period) ->
      cardsData = ctrl.metrics.leaders.sales?[period] or [{}, {}, {}]
      chartData = ensureMinLen(cardsData, 3, {})

      title: "Top Sales Reps for #{period}"
      data: chartData[...3].map (leader, pos) ->
        if leader.difference
          diff = leader.difference

          {
            title: "#{helpers.positions[pos]} Place"
            value: leader.name
            description: "#{leader.valueText} (#{diff.percentText} #{diff.direction} than previous month)"
            color: diff.color
          }
        else
          {
            title: "#{helpers.positions[pos]} Place"
            value: "No data"
            description: "Please try again when there is more data available"
            color: 'red'
          }

    statCardsData = periods[-2..].map (period, periodPos) ->
      limitedCategories.map (category, categoryPos) ->
        metric = ctrl.metrics[category.id][period]
        all = metric?.all

        {
          id: "statCard#{category.title}#{periodPos}"
          title: "Rep #{category.title}"
          subTitle: "Sales Rep #{category.title} for #{period}"
          period: period
          description: "Sales Reps have total #{category.title} of #{all?.valueText or '$0'}"
          color: colors.category[categoryPos].class
          progressBarData: reps.map (rep, repPos) ->

            if all
              value = (metric?[rep]?.value or 0) / all.value
              rounded = (Math.round value * 10) * 10
            else
              rounded = 0

            {
              color: colors.rep[repPos].class
              title: rep
              value: rounded
              description: metric?[rep]?.valueText or "$0"
            }
        }

  [
    m '.br-pagetitle', [
      m 'div', [
        m 'h4', site.title
        m 'p.mg-b-0', site.description
      ]
    ]

    m '.br-pagebody', [
      m '.row row-sm',
        if ctrl.metrics.populated
          statBoxData.map (data, pos) ->
            margin = helpers.getMarginTop pos, {sm: 12, md: 12, lg: 4}
            m ".col-md-12 col-lg-4 #{margin}", m StatBox, data
        else if ctrl.metrics.error
          margin = helpers.getMarginTop()
          m ".col-md-12 col-lg-4 #{margin}", m 'h3.tx-danger', "#{ctrl.metrics.error}"
        else
          margin = helpers.getMarginTop()
          m '', [
            m '.loading'
            m '.lead', 'Loading...'
          ]

      if ctrl.metrics.populated
        [
          # TODO: make these classes
          # hidden-xs
          m '.row row-sm mg-t-20 d-none d-sm-flex', [
            m '.col-sm-6', m ChartVertical, Object.assign({id: 'vertMetrics'}, monthlyMetricsAttrs)
            m '.col-sm-6', m ChartVertical, Object.assign({id: 'vertCommisions'}, monthlyCommisionsAttrs)
          ]

          # visible xs
          m '.row row-sm mg-t-20 d-flex d-sm-none', [
            m '.col-xs-12', m ChartHorizontal, Object.assign({id: 'horzMetrics'}, monthlyMetricsAttrs)
            m '.col-xl-12', m ChartHorizontal, Object.assign({id: 'horzCommisions'}, monthlyCommisionsAttrs)
          ]

          m '.row row-sm mg-t-20',
            infoCardsData.map (data) -> m ".col-md-6", m InfoCard, data

          m 'div.mg-t-20'

          statCardsData.map (cardData) ->
            m '.row row-sm mg-t-20', cardData.map (data, pos) ->
              margin = helpers.getMarginTop pos, {sm: 12, md: 4}
              m ".col-sm-12 col-md-4 #{margin}", m StatCard, data
        ]
    ]
    m 'footer.br-footer', [
      m '.footer-left',
        m '.mg-b-2', [
          'Copyright '
          m.trust '&copy;'
          " #{year} #{author.name}. All Rights Reserved."
        ]
    ]
  ]

ensureMinLen = (data, len, fill) ->
  toFill = len - data.length
  filler = if toFill > 0 then (fill for i in [1..toFill]) else []
  data.concat(filler)
