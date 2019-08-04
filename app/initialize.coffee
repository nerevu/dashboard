require = global.require
m = require 'mithril'
Application = require 'application'
routes = require 'routes'

m.route.prefix ''

document.addEventListener 'DOMContentLoaded', ->
  location = document.getElementById 'container'
  m.route location, '/', routes Application
