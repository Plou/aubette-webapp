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
    splash = new Splash('<h1>Splash !</h1>')
    controls = new Ui('#ui', Colorswitch, '#color')

    setTimeout(->
      splash.close()
      setTimeout(->
        splash.delete()
      , 1000
      )
    , 5000
    )
    # Handle src update on hover event
    # $('.no-touch img.hover').hoverSrc()

    ###
    # Handle pulldown
    $('.pulldown').pulldown()

    # Add backToTop anchor when half a screen  is scrolled
    $('body').append('<a id="backToTop" href="#">Back to top</a>')
    $('#backToTop').backToTop($(window).height()/2)

    # Refresh scroll offset of backToTop button appearance
    $(window).bind('resize', ->
      $('#backToTop').backToTop($(window).height()/2)
    )
    ###
  )
)
