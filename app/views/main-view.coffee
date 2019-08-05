m = require 'mithril'
ChartHorizontal = require './components/chart-horizontal'
ChartVertical = require './components/chart-vertical'
StatBox = require './components/stat-box'
StatCard = require './components/stat-card'

config = require 'config'
author = config.author

module.exports = (vnode, attrs) ->
  ctrl = vnode.state.ctrl
  attrs = Object.assign attrs or {}, vnode.attrs
  site = config.site
  rows = ctrl.metrics.list
  year = (new Date()).getFullYear()
  months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

  statBoxData = [
    {
      id: 'statBoxSales'
      color: 'purple'
      icon: 'bag'
      title: "Sales (Month-to-date)"
      value: '$18,731'
      description: '10% higher than last month'
      chartData: [
        {x: 0, y: 40}
        {x: 1, y: 49}
        {x: 2, y: 38}
        {x: 3, y: 30}
        {x: 4, y: 32}
        {x: 5, y: 40}
      ]
    }, {
      id: 'statBoxProfit'
      color: 'success'
      icon: 'cash'
      title: "Profit (Month-to-date)"
      value: '$13,728'
      description: '12% higher than last month'
      chartData: [
        {x: 0, y: 40}
        {x: 1, y: 49}
        {x: 2, y: 38}
        {x: 3, y: 30}
        {x: 4, y: 32}
        {x: 5, y: 40}
      ]
    }, {
      id: 'statBoxCommissions'
      color: 'warning'
      icon: 'ribbon-a'
      title: "Commissions Owed (Month-to-date)"
      value: '$2,236'
      description: '9% higher than last month'
      chartData: [
        {x: 0, y: 40}
        {x: 1, y: 49}
        {x: 2, y: 38}
        {x: 3, y: 30}
        {x: 4, y: 32}
        {x: 5, y: 40}
      ]
    }
  ]

  chartVerticalAttrs =
    pos: 0
    id: 'monthlyMetrics'
    title: "Monthly Metrics (past 12 months)"
    description: 'Alegna Sales, Profit, and Commissions Owed over the past 12 months'
    chartData:
      labels: months
      datasets: [
        {
          label: 'Sales'
          data: [10, 24, 20, 25, 35, 50, 10, 24, 20, 25, 35, 50]
          backgroundColor: '#6f42c1'
          borderWidth: 1
          fill: true
        },{
          label: 'Profit'
          data: [10, 24, 20, 25, 35, 50, 10, 24, 20, 25, 35, 50],
          backgroundColor: '#23BF08',
          borderWidth: 1,
          fill: true
        },{
          label: 'Commissions'
          data: [20, 30, 28, 33, 45, 65, 10, 24, 20, 25, 35, 50],
          backgroundColor: '#F49917',
          borderWidth: 1,
          fill: true
        }
      ]

  chartHorizontalAttrs =
    pos: 0
    id: 'monthlyCommisions'
    title: "Monthly Commissions (past 12 months)"
    description: 'Sales Rep Commissions over the past 12 months'
    infoGroup:
      title: "Top Sales Reps for month of May"
      data: [
        {
          title: "1st Place"
          value: 'Hosea Washington'
          description: '$2,093 (12% higher than last month)'
          color: 'success'
        }, {
          title: "2nd Place"
          value: 'Gerard Lewis'
          description: '$143 (12% higher than last month)'
          color: 'success'
        }
      ]

    chartData:
      labels: months
      datasets: [
        {
          label: 'Gerard Lewis'
          data: [10, 24, 20, 25, 35, 50, 10, 24, 20, 25, 35, 50]
          backgroundColor: '#1CAF9A'
          borderWidth: 1
          fill: true
        },{
          label: 'Hosea Washington'
          data: [10, 24, 20, 25, 35, 50, 10, 24, 20, 25, 35, 50],
          backgroundColor: '#e83e8c',
          borderWidth: 1,
          fill: true
        }
      ]

  statCardCurrentData = [
    {
      id: 'statCardCurrentSales'
      title: "Individual Sales"
      subTitle: 'Sales Rep Sales for May 2019'
      period: 'Month-to-date'
      description: 'Sales Reps sold a grand total of $20,000'
      info: 'Last updated: 5/4/19'
      color: 'purple'
      progressBarData: [
        {
          color: 'teal'
          title: 'Gerard Lewis'
          value: 50
          description: '$7,728'
        }, {
          color: 'pink'
          title: 'Hosea Washington'
          value: 80
          description: '$13,728'
        }
      ]
    }, {
      id: 'statCardCurrentProfit'
      title: "Individual Profit"
      subTitle: 'Sales Rep Profit for May 2019'
      period: 'Month-to-date'
      description: 'Sales Reps made a grand total profit of $20,000'
      info: 'Last updated: 5/4/19'
      color: 'success'
      progressBarData: [
        {
          color: 'teal'
          title: 'Gerard Lewis'
          value: 50
          description: '$7,728'
        }, {
          color: 'pink'
          title: 'Hosea Washington'
          value: 80
          description: '$13,728'
        }
      ]
    }, {
      id: 'statCardCurrentCommissions'
      title: "Individual Commissions"
      subTitle: 'Sales Rep Commissions owed for May 2019'
      period: 'Month-to-date'
      description: 'Sales Reps are owed a grand total commission of $20,000'
      info: 'Last updated: 5/4/19'
      color: 'warning'
      progressBarData: [
        {
          color: 'teal'
          title: 'Gerard Lewis'
          value: 50
          description: '$7,728'
        }, {
          color: 'pink'
          title: 'Hosea Washington'
          value: 80
          description: '$13,728'
        }
      ]
    }
  ]

  statCardPreviousData = [
    {
      id: 'statCardPreviousSales'
      title: "Individual Sales"
      subTitle: 'Sales Rep Sales for April 2019'
      period: 'April 2019'
      description: 'Sales Reps sold a grand total of $20,000'
      info: 'Last updated: 5/4/19'
      color: 'purple'
      progressBarData: [
        {
          color: 'teal'
          title: 'Gerard Lewis'
          value: 50
          description: '$7,728'
        }, {
          color: 'pink'
          title: 'Hosea Washington'
          value: 80
          description: '$13,728'
        }
      ]
    }, {
      id: 'statCardPreviousProfit'
      title: "Individual Profit"
      subTitle: 'Sales Rep Profit for April 2019'
      period: 'April 2019'
      description: 'Sales Reps made a grand total profit of $20,000'
      info: 'Last updated: 5/4/19'
      color: 'success'
      progressBarData: [
        {
          color: 'teal'
          title: 'Gerard Lewis'
          value: 50
          description: '$7,728'
        }, {
          color: 'pink'
          title: 'Hosea Washington'
          value: 80
          description: '$13,728'
        }
      ]
    }, {
      id: 'statCardPreviousCommissions'
      title: "Individual Commissions"
      subTitle: 'Sales Rep Commissions owed for April 2019'
      period: 'April 2019'
      description: 'Sales Reps are owed a grand total commission of $20,000'
      info: 'Last updated: 5/4/19'
      color: 'warning'
      progressBarData: [
        {
          color: 'teal'
          title: 'Gerard Lewis'
          value: 50
          description: '$7,728'
        }, {
          color: 'pink'
          title: 'Hosea Washington'
          value: 80
          description: '$13,728'
        }
      ]
    }
  ]

  [
    m '.br-pagetitle', [
      m 'i.icon ion-ios-home-outline'
      m 'div', [
        m 'h4', site.title
        m 'p.mg-b-0', site.description
      ]
    ]

    m '.br-pagebody', [
      m '.row row-sm', statBoxData.map (data) ->
        m '.col-sm-12 col-xl-4', m StatBox, data

      m '.row row-sm mg-t-20',
        m '.col-sm-12', [
          m ChartVertical, chartVerticalAttrs
          m ChartHorizontal, chartHorizontalAttrs
        ]

      m '.row row-sm mg-t-20', statCardCurrentData.map (data) ->
        m '.col-sm-4', m StatCard, data

      m '.row row-sm mg-t-20', statCardPreviousData.map (data) ->
        m '.col-sm-4', m StatCard, data

      m '.row row-sm mg-t-20',
        m '.col-sm-12',
          if rows
            headerValues = Object.keys rows[0]

            m 'table.table table-hover table-bordered', [
              m 'thead.thead-colored thead-info',
                m 'tr', headerValues.map (value) ->
                  m 'th', {'scope': 'col'}, value

              m 'tbody', rows.map (row) ->
                m 'tr', Object.values(row).map (value) -> m 'td', value
            ]
          else
            m 'p.lead', 'Loading...'

      # m '.row row-sm mg-t-20', [
      #   m '.col-lg-4 mg-t-20 mg-lg-t-0', [
      #     m '.card shadow-base bd-0 overflow-hidden', [
      #       m '.pd-x-25 pd-t-25', [
      #         m 'h6.tx-13 tx-uppercase tx-inverse tx-semibold tx-spacing-1 mg-b-20', 'Storage Overview'
      #         m 'p.tx-10 tx-spacing-1 tx-mont tx-semibold tx-uppercase mg-b-0', 'As of Today'
      #         m 'h1.tx-56 tx-light tx-inverse mg-b-0', [
      #           '755'
      #           m 'span.tx-teal tx-24', 'gb'
      #         ]
      #         m 'p', [
      #           m 'span.tx-primary', '80%'
      #           ' of free space remaining'
      #         ]
      #       ]
      #       m '#ch6.ht-115 mg-r--1'
      #       m '.bg-teal pd-x-25 pd-b-25 d-flex justify-content-between', [
      #         m '.tx-center', [
      #           m 'h3.tx-lato tx-white mg-b-5', [
      #             '989'
      #             m 'span.tx-light op-8 tx-20', 'gb'
      #           ]
      #           m 'p.tx-10 tx-spacing-1 tx-mont tx-medium tx-uppercase mg-b-0 tx-white-8', 'Total Space'
      #         ]
      #         m '.tx-center', [
      #           m 'h3.tx-lato tx-white mg-b-5', [
      #             '234'
      #             m 'span.tx-light op-8 tx-20', 'gb'
      #           ]
      #           m 'p.tx-10 tx-spacing-1 tx-mont tx-medium tx-uppercase mg-b-0 tx-white-8', 'Used Space'
      #         ]
      #         m '.tx-center', [
      #           m 'h3.tx-lato tx-white mg-b-5', [
      #             '80'
      #             m 'span.tx-light op-8 tx-20', '%'
      #           ]
      #           m 'p.tx-10 tx-spacing-1 tx-mont tx-medium tx-uppercase mg-b-0 tx-white-8', 'Free Space'
      #         ]
      #       ]
      #     ]
      #     m '.card shadow-base bd-0 mg-t-20',
      #       m '.bg-white ht-300 pos-relative overflow-hidden d-flex flex-column align-items-start rounded', [
      #         m '.pd-x-30 pd-t-30 mg-b-auto', [
      #           m 'p.tx-info tx-uppercase tx-11 tx-semibold tx-mont mg-b-5', 'Product Item #1'
      #           m 'h5.tx-inverse mg-b-20', 'Samsung Galaxy S8'
      #           m 'p.tx-uppercase tx-11 tx-semibold tx-mont mg-b-0', 'Purchases'
      #           m 'h2.tx-inverse tx-lato tx-bold mg-b-0', '2366'
      #           m 'span', '53.86 purchases/month'
      #         ]
      #         m '#ch10.ht-100 tr-y-1'
      #       ]

      #     m '.card card-body bd-0 pd-25 bg-primary mg-t-20', [
      #       m '.d-xs-flex justify-content-between align-items-center tx-white mg-b-20', [
      #         m 'h6.tx-13 tx-uppercase tx-semibold tx-spacing-1 mg-b-0', 'Server Status'
      #         m 'span.tx-12 tx-uppercase', 'Oct 2017'
      #       ]
      #       m 'p.tx-sm tx-white tx-medium mg-b-0', 'Hardware Monitoring'
      #       m 'p.tx-12 tx-white-7', 'Intel Dothraki G125H 2.5GHz'
      #       m '.progress bg-white-3 rounded-0 mg-b-0',
      #         m '.progress-bar bg-success wd-50p lh-3', {
      #           'role': 'progressbar'
      #           'aria-valuenow': '50'
      #           'aria-valuemin': '0'
      #           'aria-valuemax': '100'
      #         }, '50%'
      #       m 'p.tx-11 mg-b-0 mg-t-15 tx-white-7', 'Notice: Lorem ipsum dolor sit amet.'
      #     ]
      #     m '.card bg-danger bd-0 mg-t-20',
      #       m '.pd-x-25 pd-t-25', [
      #         m 'h6.tx-13 tx-uppercase tx-white tx-medium tx-spacing-1 mg-b-10', 'Monthly Statistics'
      #         m 'p.mg-b-20 tx-white-6', 'Past 30 Days — Last Updated Oct 14, 2017'
      #         m '.row row-sm mg-t-20', [
      #           m '.col', [
      #             m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold tx-white-6', 'Bounce Rate'
      #             m 'h4.tx-lato tx-white tx-bold tx-normal mg-b-0', '23.32%'
      #             m 'span.tx-12 tx-white-6 tx-roboto', '2.7% increased'
      #           ]
      #           m '.col', [
      #             m 'p.mg-b-5 tx-uppercase tx-10 tx-mont tx-semibold tx-white-6', 'Page Views'
      #             m 'h4.tx-lato tx-white tx-normal mg-b-0', '42.58%'
      #             m 'span.tx-12 tx-white-6 tx-roboto', '1.5% decreased'
      #           ]
      #         ]
      #         m '#ch13.ht-160'
      #       ]
      #   ]
      # ]
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
