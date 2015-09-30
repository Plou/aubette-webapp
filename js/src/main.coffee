# Helpers
#
# getHash = require './components/getHash.coffee'
Colorswitch = require('./components/Colorswitch.coffee')
Ui = require('./components/Ui.coffee')
Splash = require('./components/Splash.coffee')

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
    controls = new Ui('#ui', Colorswitch, '#color')

    setTimeout(->
      splash.close()
      setTimeout(->
        splash.delete()
      , 1000
      )
    , 3000
    )
  )
)
