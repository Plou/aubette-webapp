
class Mondrian

  constructor: (id) ->
    @controls = require('../../vendors/mondrian-generator.js')
    @$canvas = $(id)
    @$parent = @$canvas.parent()
    @speed =
      value: 3000
      min: 300
      max: 5000
    @status = 'stop'

    @refresh()
    @bind()
    return @

  getSpeedRatio: ->
    return (@speed.value -  @speed.min) / (@speed.max -  @speed.min)

  getSpeed: ->
    return @speed.value

  setSpeed: (percent) ->
    percent ?= Math.random()
    @speed.value = Math.floor((percent * (@speed.max - @speed.min)) + @speed.min)
    @updateSpeed()
    return @

  updateSpeed: ->
    @status = 'starting'
    @stop()
    @start()
    @status = 'started'
    return @

  hide: ->
    @stop()
    @$canvas.fadeOut(300).hide()
    return @

  show: ->
    @updateSpeed()
    @$canvas.fadeIn(300).show()
    return @

  start: ->
    @timer = setInterval( =>
      @refresh()
    , @speed.value )
    @status = 'started'
    return @

  stop: ->
    clearInterval(@timer)
    @status = 'stopped'
    return @

  compose: ->
    @controls.compose()
    return @

  clear: ->
    @controls.clear()
    return @

  refresh: ->
    @$canvas.attr('width', @$parent.width())
    @$canvas.attr('height', @$parent.height())
    @compose()
    return @

  bind: ->
    $(window).on('resize', =>
      @refresh()
    )
    @$canvas.on('click', =>
      if @status == 'stopped'
        @compose()
    )
    return @

module?.exports = Mondrian
