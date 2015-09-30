( ($) ->
  # Create a popin wrapper around a content
  # @param content [String\HTML node] The pipin content
  #
  # @return [Popin]

  class Popin
    constructor: (content) ->
      @popinClass ?= 'popin'
      @template ?= require('../templates/popin.html')
      @create(content)
      @close()
      @bind()
      return this

    create: (content) ->
      @$el = $(@template)
      @$elContent = @$el.find('.' + @popinClass + '-content')
      @$elContent.html(content)
      $('body').append(@$el)
      return this

    toggle: ->
      if @isOpen
        @close()
      else
        @open()
      return this

    open: ->
      @$el.addClass(@popinClass + '-isopen')
      @isOpen = true
      @$el.removeClass(@popinClass + '-isclose')
      @isClose = false
      @$el.trigger('open')
      return this

    close: ->
      @$el.addClass(@popinClass + '-isclose')
      @isClose = true
      @$el.removeClass(@popinClass + '-isopen')
      @isOpen = false
      @$el.trigger('close')
      return this

    delete: ->
      @$el.remove()
      return @

    bind: ->
      @$el.on( 'click', (e) =>
        unless $(e.target).closest('.' + @popinClass + '-content').length
          @close()
      )
      return this
  module?.exports = Popin
)(jQuery)
