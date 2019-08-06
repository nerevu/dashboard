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
        'node_modules/ionicons/fonts'
      ]
      verbose: true
      onlyChanged: true

  npm:
    styles:
      ionicons: ['css/ionicons.min.css']
      rickshaw: ['rickshaw.min.css']

    globals:
      _: "lodash"
      Rickshaw: "rickshaw"
      Chart: "chart.js"

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

  sourceMaps: "absoluteUrl"
