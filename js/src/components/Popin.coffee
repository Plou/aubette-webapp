( ($) ->
  # Create a popin wrapper around a content
  # @param content [String\HTML node] The pipin content
  #
  # @return [Popin]

  class Popin
    constructor: (content) ->
      @create(content)
      @close()
      @bind()
      return this

    create: (content) ->
      @$el = $('<div class="popin"><div class="popin-content"></div><button class="icon-fermeture">x</button></div>')
      @$elContent = @$el.find('.popin-content')
      @$elContent.html(content)
      $('body').append(@$el)
      return this

    open: ->
      @$el.show()
      @$el.trigger('open')
      return this

    close: ->
      @$el.hide()
      @$el.trigger('close')
      return this

    bind: ->
      @$el.on( 'click', (e) =>
        unless $(e.target).closest('.popin-content').length
          @close()
      )
      return this
  module?.exports = Popin
)(jQuery)
