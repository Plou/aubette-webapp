window.$ = window.jQuery = require('../vendors/jquery-1.11.2.min.js')
# Helpers
#
# getHash = require './components/getHash.coffee'
Colorswitch = require('./components/Colorswitch.coffee')
Ui = require('./components/Ui.coffee')
Splash = require('./components/Splash.coffee')
Mondrian = require('./components/Mondrian.coffee')
# jQuery helpers
#

# Website wide scripts
# @author Dummy Team
#
$( ->
  $(window).ready( ->
    if window.navigator.standalone? && window.navigator.standalone
      $('body').addClass('device-ios device-standalone')
      $('body').removeClass('device-help')

    if /iPad|iPhone|iPod/.test(navigator.platform)
      $('body').addClass('device-ios')
    else if /Android|android|Linux/.test(navigator.platform)
      $('body').addClass('device-android')
    else
      $('body').addClass('device-other')

    splash = new Splash()
    window.controls = new Ui('#ui', [
      {id: 'color', class: Colorswitch, selector: '#color'},
      {id: 'mondrian', class: Mondrian, selector: '#mondrian'}
    ])

    setTimeout(->
      splash.close()
      setTimeout(->
        splash.delete()
      , 1000
      )
    , 0
    )

  )
)
