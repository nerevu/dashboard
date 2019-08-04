exports.config =
  # http://brunch.io/docs/config
  plugins:
    coffeelint:
      pattern: /^app\/.*\.coffee$/
      options:
        indentation:
          value: 2
          level: 'error'
        max_line_length:
          value: 160

    cleancss:
      keepSpecialComments: 0
      removeEmpty: true

    uglify:
      mangle: true

    sass:
      allowCache: true

    copycat:
      fonts: [
        'node_modules/@fortawesome/fontawesome-free/webfonts'
        'node_modules/ionicons/fonts'
      ]
      verbose: true
      onlyChanged: true

  npm:
    styles:
      # '@fortawesome': ['fontawesome-free/css/all.min.css']
      ionicons: ['css/ionicons.min.css']
      rickshaw: ['rickshaw.min.css']

    globals:
      jQuery: "jquery"
      flot: "jquery.flot"
      # sparkline: "jquery-sparkline"
      echarts: "echarts"
      spline: "flot-spline"
      _: "lodash"
      Rickshaw: "rickshaw"

  server:
    hostname: "0.0.0.0"
    port: 3333

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^app/
        'stylesheets/vendor.css': /^(?!app)/

    templates:
      joinTo: 'javascripts/app.js': /^app/

  sourceMaps: "absoluteUrl"
