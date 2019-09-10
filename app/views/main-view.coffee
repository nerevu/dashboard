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
  visible = ctrl.metrics.visible
  #################################################
  # TODO: remove this when better logic is created.
  # This is for testing purposes
  if ctrl.page() is undefined
    ctrl.page('sales')
  #################################################

  year = (new Date()).getFullYear()

  if ctrl.metrics.populated
    periods = ctrl.metrics.periods
    currentPeriod = periods[-1..]
    reps = ctrl.metrics.reps
    categories = ctrl.metrics.categories
    if ctrl.page() isnt 'admin'
      categories = ctrl.metrics.categories.filter (cat) -> cat.id isnt 'profit'

    upsell_and_categories = (c for c in categories when c.id not in ['weighted_avg_sales'])
    limited_categories = (c for c in categories when c.id not in ['weighted_avg_sales', 'total_upsells'])
    statBoxData = limited_categories.map (category) ->
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
      title: "Monthly Metrics (past 12 months)"
      description: 'Alegna Sales, Profit, and Commissions Owed over the past 12 months'
      chartData:
        labels: periods
        datasets: upsell_and_categories.map (category) ->
          metric = ctrl.metrics[category.id]

          {
            label: category.title
            data: periods.map (period) ->
              if metric[period] then metric[period].all.value else 0

            backgroundColor: category.backgroundColor
            borderWidth: 1
            fill: true
          }
    if ctrl.page() isnt 'admin'
      monthlyMetricsAttrs.description =  'Alegna Sales and Commissions Owed over the past 12 months'

    monthlyCommisionsAttrs =
      pos: 0
      title: "Monthly Commissions (past 12 months)"
      description: 'Sales Rep Commissions over the past 12 months'
      chartData:
        labels: periods
        datasets: reps.map (rep, pos) ->
          metric = ctrl.metrics.commission

          {
            label: rep
            data: periods.map (period) -> metric[period]?[rep]?.value or 0
            backgroundColor: colors.rep[pos].hex
            borderWidth: 1
            fill: true
          }

    monthlyWeightedSalesAttrs =
      pos: 0
      title: "Monthly Weighted Average Sales (past 12 months)"
      description: 'Sales Rep Weighted Average Sales over the past 12 months'
      chartData:
        labels: periods
        datasets: ctrl.metrics.reps.map (rep, pos) ->
          metric = ctrl.metrics.weighted_avg_sales

          {
            label: rep
            data: periods.map (period) -> metric[period]?[rep]?.value or 0
            backgroundColor: colors.rep[pos].hex
            borderWidth: 1
            fill: true
          }

    infoCardsData = periods[-2..].map (period) ->
      data = ctrl.metrics.leaders.sales?[period] or [{}, {}, {}]
      if not data.length
        data = [{}, {}, {}]
      title: "Top Sales Reps for #{period}"
      data: data[-3..].map (leader, pos) ->
        if leader.difference
          diff = leader.difference

          {
            title: "#{helpers.positions[pos]} Place"
            value: leader.name
            description: "#{leader.valueText} (#{diff.percentText} #{diff.direction} than previous month)"
            color: leader.difference.color
          }
        else
          {
            title: "#{helpers.positions[pos]} Place"
            value: "No data"
            description: "Please try again when there is more data available"
            color: 'red'
          }

    statCardsData = periods[-2..].map (period, periodPos) ->
      upsell_and_categories.map (category, categoryPos) ->
        metric = ctrl.metrics[category.id][period]
        all = metric?.all

        {
          id: "statCard#{category.title}#{periodPos}"
          title: "Individual #{category.title}"
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

    weightedAvgStatsData = periods[-2..].map (period, periodPos) ->
      categories.map (category, categoryPos) ->
        metric = ctrl.metrics[category.id][period]
        all = metric?.all

        {
          id: "statCard#{category.title}#{periodPos}"
          title: "Individual #{category.title}"
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


  #################################################
  # TODO: fix with better logic later
  statBoxWidth = 4
  statBoxWidth = 4
  statCardsWidth = 3
  if ctrl.page() isnt 'admin'
    statBoxWidth = 6
    statCardsWidth = 4
  #################################################

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
            margin = helpers.getMarginTop pos
            m ".col-sm-6 col-xl-#{statBoxWidth} #{margin}", m StatBox, data
        else
          margin = helpers.getMarginTop()
          m ".col-sm-6 col-xl-4 #{margin}", m 'p.lead', 'Loading...'

      if ctrl.metrics.populated
        [
          # TODO: make these classes
          # hidden-xs
          m '.row row-sm mg-t-20 d-none d-sm-flex', [
            m '.col-xl-6', m ChartVertical, Object.assign({id: 'vertMetrics'}, monthlyMetricsAttrs)
            m '.col-xl-6', m ChartVertical, Object.assign({id: 'vertCommisions'}, monthlyCommisionsAttrs)
            m '.col-xl-6', m ChartVertical, Object.assign({id: 'vertWeightedSales'}, monthlyWeightedSalesAttrs)
          ]

          # visible xs
          m '.row row-sm mg-t-20 d-flex d-sm-none', [
            m '.col-xs-12', m ChartHorizontal, Object.assign({id: 'horzMetrics'}, monthlyMetricsAttrs)
            m '.col-xl-12', m ChartHorizontal, Object.assign({id: 'horzCommisions'}, monthlyCommisionsAttrs)
            #################################################
            # TODO: pick up here tomorrow (add weighted chart)
            # m '.col-xl-12', m ChartHorizontal, Object.assign({id: 'horzWeightedCommissions'}, monthlyWeightedSalesAttrs)
            #################################################
          ]

          m '.row row-sm mg-t-20',
            infoCardsData.map (data) -> m ".col-md-6", m InfoCard, data

          m 'div.mg-t-20'

          statCardsData.map (cardData) ->
            m '.row row-sm mg-t-20', cardData.map (data, pos) ->
              margin = helpers.getMarginTop pos, {sm: 6, md: 4}
              m ".col-xs-12 col-sm-6 col-md-4 #{margin}", m StatCard, data
              m ".col-xs-12 col-sm-6 col-md-#{statCardsWidth} #{margin}", m StatCard, data


          m '.row row-sm mg-t-40',
            m '.col-sm-12',
              if rows
                headerValues = Object.keys rows[0]

                m 'table.table table-hover table-bordered', [
                  m 'thead.thead-colored thead-info',
                    m 'tr', headerValues.map (value) ->
                      hidden = helpers.getHidden value, visible
                      m "th.#{hidden}", {'scope': 'col'}, value

                  m 'tbody', rows.map (row) ->
                    m 'tr', Object.entries(row).map ([key, value]) ->
                      hidden = helpers.getHidden key, visible
                      m "td.#{hidden}", value
                ]
              else
                m 'p.lead', 'Loading...'
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
