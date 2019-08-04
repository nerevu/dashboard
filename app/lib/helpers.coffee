m = require 'mithril'
ResizeSensor = require('css-element-queries').ResizeSensor

config = require 'config'
devconfig = require 'devconfig'

$ = jQuery

remove = (orginal, toRemove) ->
  regex = "(^|\\b)#{toRemove.split(' ').join('|')}(\\b|$)"
  orginal.replace(new RegExp(regex, 'gi'), ' ')

addClass = (el, className) ->
  if el.classList and not el.classList.contains(className)
    el.classList.add(className)
  else if el.className.indexOf(className) is -1
    el.className += " #{className}"

removeClass = (el, className) ->
  if el.classList and el.classList.contains(className)
    el.classList.remove className
  else if el.className.indexOf(className) is -1
    el.className = remove el.className, className

replaceClass = (el, oldClassName, newClassName) ->
  removeClass el, oldClassName
  addClass el, newClassName

graphData = [
  {
    renderer: 'area'
    stack: true
    id: 'ch1'
    series: [
      {
        data: [
          {x: 0, y: 40}
          {x: 1, y: 49}
          {x: 2, y: 38}
          {x: 3, y: 30}
          {x: 4, y: 32}
          {x: 5, y: 40}
          {x: 6, y: 20}
          {x: 7, y: 10}
          {x: 8, y: 20}
          {x: 9, y: 25}
          {x: 10, y: 35}
          {x: 11, y: 20}
          {x: 12, y: 40}
        ]

        color: 'rgba(255,255,255,0.5)'
      }
    ]
  }, {
    renderer: 'area'
    stack: true
    id: 'ch2'
    series: [
      {
        data: [
          {x: 0, y: 40}
          {x: 1, y: 15}
          {x: 2, y: 38}
          {x: 3, y: 40}
          {x: 4, y: 32}
          {x: 5, y: 50}
          {x: 6, y: 65}
          {x: 7, y: 70}
          {x: 8, y: 45}
          {x: 9, y: 55}
          {x: 10, y: 60}
          {x: 11, y: 50}
          {x: 12, y: 40}
        ]

        color: 'rgba(255,255,255,0.5)'
      }
    ]
  }, {
    renderer: 'area'
    stack: true
    id: 'ch3'
    series: [
      {
        data: [
          {x: 0, y: 40}
          {x: 1, y: 45}
          {x: 2, y: 30}
          {x: 3, y: 40}
          {x: 4, y: 50}
          {x: 5, y: 40}
          {x: 6, y: 20}
          {x: 7, y: 10}
          {x: 8, y: 20}
          {x: 9, y: 25}
          {x: 10, y: 35}
          {x: 11, y: 20}
          {x: 12, y: 40}
        ]

        color: 'rgba(255,255,255,0.5)'
      }
    ]
  }, {
    renderer: 'area'
    stack: true
    id: 'ch4'
    series: [
      {
        data: [
          {x: 0, y: 40}
          {x: 1, y: 45}
          {x: 2, y: 30}
          {x: 3, y: 40}
          {x: 4, y: 50}
          {x: 5, y: 40}
          {x: 6, y: 20}
          {x: 7, y: 10}
          {x: 8, y: 20}
          {x: 9, y: 25}
          {x: 10, y: 35}
          {x: 11, y: 20}
          {x: 12, y: 40}
        ]
        color: 'rgba(255,255,255,0.5)'
      }
    ]
  }, {
    renderer: 'area'
    stack: true
    id: 'ch6'
    series: [
      {
        data: [
          {x: 0, y: 40}
          {x: 1, y: 49}
          {x: 2, y: 38}
          {x: 3, y: 30}
          {x: 4, y: 32}
          {x: 5, y: 40}
          {x: 6, y: 20}
          {x: 7, y: 10}
          {x: 8, y: 20}
          {x: 9, y: 25}
          {x: 10, y: 35}
          {x: 11, y: 20}
          {x: 12, y: 40}
        ]
        color: '#1CAF9A'
      }
    ]
  }, {
    renderer: 'bar'
    stack: true
    id: 'ch10'
    series: [
      {
        data: [
          {x: 0, y: 40}
          {x: 1, y: 49}
          {x: 2, y: 38}
          {x: 3, y: 30}
          {x: 4, y: 32}
          {x: 5, y: 40}
          {x: 6, y: 20}
          {x: 7, y: 10}
          {x: 8, y: 20}
          {x: 9, y: 25}
          {x: 10, y: 35}
          {x: 11, y: 20}
          {x: 12, y: 35}
        ]
        color: '#6F42C1'
      }
    ]
  # }, {
  #   renderer: 'bar'
  #   stack: true
  #   id: 'ch11'
  #   series: [
  #     {
  #       data: [
  #         {x: 0, y: 35}
  #         {x: 1, y: 49}
  #         {x: 2, y: 38}
  #         {x: 3, y: 30}
  #         {x: 4, y: 32}
  #         {x: 5, y: 40}
  #         {x: 6, y: 20}
  #         {x: 7, y: 10}
  #         {x: 8, y: 20}
  #         {x: 9, y: 25}
  #         {x: 10, y: 35}
  #         {x: 11, y: 20}
  #         {x: 12, y: 40}
  #       ]
  #       color: '#6F42C1'
  #     }
  #   ]
  }, {
    renderer: 'bar'
    stack: false
    id: 'ch13'
    series: [
      {
        data: [
          {x: 0, y: 20}
          {x: 1, y: 25}
          {x: 2, y: 10}
          {x: 3, y: 15}
          {x: 4, y: 20}
          {x: 5, y: 40}
          {x: 6, y: 15}
          {x: 7, y: 40}
          {x: 8, y: 25}
        ]
        color: '#f25766'
      }
      {
        data: [
          {x: 0, y: 10}
          {x: 1, y: 30}
          {x: 2, y: 45}
          {x: 3, y: 30}
          {x: 4, y: 42}
          {x: 5, y: 20}
          {x: 6, y: 30}
          {x: 7, y: 15}
          {x: 8, y: 20}
        ]
        color: '#aa2531'
      }
    ]
  }
]

sparklineOpts =
  type: 'bar'
  barWidth: 10
  height: 70
  chartRangeMax: 12

newCust = [
  [0, 8]
  [1, 7]
  [2, 7]
  [3, 8]
  [4, 7]
  [5, 8]
  [6, 9]
  [7, 9]
  [8, 9]
  [9, 8]
  [10, 9]
  [11, 8]
  [12, 7]
  [13, 8]
  [14, 7]
  [15, 7]
  [16, 8]
  [17, 9]
  [18, 9]
  [19, 10]
]

retCust = [
  [0, 1]
  [1, 2]
  [2, 3]
  [3, 3]
  [4, 2]
  [5, 3]
  [6, 4]
  [7, 5]
  [8, 4]
  [9, 5]
  [10, 4]
  [11, 4]
  [12, 3]
  [13, 4]
  [14, 4]
  [15, 5]
  [16, 5]
  [17, 4]
  [18, 6]
  [19, 7]
]

barChartData = [
  {name: 'Oranges', type: 'bar', data: [20, 20, 36, 12, 15]}
  {name: 'Apples', type: 'bar', data: [8, 5, 25, 10, 10]}
]

module.exports =
  addClass: addClass
  removeClass: removeClass
  replaceClass: replaceClass
  log: console.log

  hasClass: (el, className) ->
    if el.classList
      el.classList.contains(className)
    else
      el.className is className

  addMeta: (head, key, value, keyType='name') ->
    meta = document.createElement 'meta'
    meta.setAttribute keyType, key
    meta.setAttribute 'content', value
    head.appendChild meta

  updateMeta: (key, value, keyType='name') ->
    if keyType is 'name'
      meta = document.getElementsByName(key)[0]
    else if keyType is 'property'
      _.forEach document.getElementsByTagName('meta'), (el) ->
        if el?.attributes?.property?.value?.includes key
          meta = el

    meta?.setAttribute 'content', value

  capitalize: (text) -> "#{text[0].toUpperCase()}#{text.substring 1}"
  getRandomIndex: (items) -> Math.floor(Math.random() * items.length)

  isVisible: (name, isClass) ->
    if isClass
      el = document.getElementsByClassName(name)[0]
      el?.classList?.contains name
    else
      Boolean(document.getElementById(name)?.id)

  getModels: (ids, collection) ->
    models = []

    ids.forEach (id) ->
      model = collection.get id

      if model
        models.push model

    models

  uniqSort: (array) -> _.sortedUniq _.sortBy array
  replaceUrl: (old, _new) ->
    m.route.set m.route.get().replace(old, _new), null, replace: true

  initGraphs: ->
    graphData.forEach (datum) ->
      element = document.getElementById(datum.id)
      console.log {id: datum.id, element}
      graph = new (Rickshaw.Graph)
        element: document.getElementById(datum.id)
        max: 80
        renderer: datum.renderer
        stack: datum.stack
        series: datum.series

      graph.render()

      new ResizeSensor $('.br-mainpanel'), ->
        graph.configure
          width: $("##{datum.id}").width(), height: $("##{datum.id}").height()

        graph.render()

  initPlot: ->
    plot = $.plot $('#ch5'), [
      {data: newCust, label: 'Bounce Rate', color: '#17A2B8'}
      {data: retCust, label: 'Page Views', color: '#4E6577'}
    ],
      series:
        lines:
          show: false

        splines:
          show: true
          tension: 0.4
          lineWidth: 0
          fill: 0.5

        shadowSize: 0

      points:
        show: false

      grid:
        hoverable: true
        clickable: true
        borderColor: '#ddd'
        borderWidth: 0
        labelMargin: 5
        backgroundColor: '#fff'

      yaxis:
        min: 0
        max: 15
        color: '#eee'
        font: {size: 10, color: '#999'}

      xaxis:
        color: '#eee'
        font: {size: 10, color: '#999'}

  initSparklines: ->
    $('#ch7').sparkline 'html', Object.assign({barColor: '#17A2B8'}, sparklineOpts)
    $('#ch8').sparkline 'html', Object.assign({barColor: '#20C997'}, sparklineOpts)
    $('#ch9').sparkline 'html', Object.assign({barColor: '#3A4293'}, sparklineOpts)

  initBarChart: ->
    ch12 = echarts.init document.getElementById('ch12')
    ch12.setOption(
      grid: {top: '6', right: '0', bottom: '17', left: '32'}

      xAxis:
        type: 'value'

        axisLine:
          lineStyle:
            color: '#ccc'

        axisLabel:
          fontSize: 10
          color: '#666'

      yAxis:
        type: 'category'
        data: ['2006', '2008', '2010', '2012', '2014']
        splitLine:
          lineStyle:
            color: '#ddd'

        axisLine:
          lineStyle:
            color: '#ccc'

        axisLabel:
          fontSize: 10
          color: '#666'

      series: barChartData
      color: ['#17A2B8', '#6F42C1']
    )
