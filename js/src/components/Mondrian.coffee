controls = require('../../vendors/mondrian-generator.js')

class Mondrian

  constructor: (id) ->
    @$canvas = $(id)
    @$parent = @$canvas.parent()

    @refresh()
    @bind()
    return @

  compose: ->
    controls.compose()
    return @

  clear: ->
    controls.clear()
    return @

  refresh: ->
    @$canvas.attr('width', @$parent.width())
    @$canvas.attr('height', @$parent.height())
    return @

  bind: ->
    $(window).on('resize', =>
      @refresh()
    )
    @$canvas.on('click', =>
      @compose()
    )
    return @

module?.exports = Mondrian
