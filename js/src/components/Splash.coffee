Popin = require('./Popin.coffee')

( ($) ->
  # Create a Splash Screen
  # @param content [String\HTML node] The pipin content
  #
  # @return [Splash]

  class Splash extends Popin
    constructor: (content) ->
      @popinClass = 'splash'
      super(content)
      @open()
      return this

    create: (content) ->
      @$el = $('<div class="' + @popinClass + '"><div class="' + @popinClass + '-content"></div></div>')
      @$elContent = @$el.find('.' + @popinClass + '-content')
      @$elContent.html(content)
      $('body').append(@$el)
      return this

  module?.exports = Splash
)(jQuery)
