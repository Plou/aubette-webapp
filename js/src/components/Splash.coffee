Popin = require('./Popin.coffee')

( ($) ->
  # Create a Splash Screen
  # @param content [String\HTML node] The pipin content
  #
  # @return [Splash]

  class Splash extends Popin
    constructor: (content) ->
      @popinClass = 'splash'
      @template = require('../templates/splash.html')
      super(content)
      @open()
      return this


  module?.exports = Splash
)(jQuery)
