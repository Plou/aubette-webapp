# Update colors
# @param
#
# @return [Colorswitch]
class Colorswitch
  constructor: (selector) ->
    @body = document.querySelector(selector)
    @$body = $(@body)
    @colors = require('./colors.coffee')
    @speed =
      value: 3000
      min: 300
      max: 5000
    @status = 'stop'

    @updateColor()
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
    @$body.fadeOut(300).hide()
    return @

  show: ->
    @updateSpeed()
    @$body.fadeIn(300).show()
    return @

  start: ->
    @timer = setInterval( =>
      @updateColor()
    , @speed.value )
    @status = 'started'
    return @

  stop: ->
    clearInterval(@timer)
    @status = 'stopped'
    return @

  getRandomIndex: (array) ->
    return Math.floor(Math.random() * array.length)

  getRandomColor: ->
    color = @colors[@getRandomIndex(@colors)]
    while color == @getColor()
      color = @colors[@getRandomIndex(@colors)]
    return color

  setRandomColor: ->
    @setColor(getRandomColor())
    return @

  setColor: (color) ->
    if !color? or color in @colors
      @color = if color then color else @getRandomColor()
    return @

  getColor: ->
    return @color

  updateColor: (color, duration, easing) ->
    if !color? or color in @colors
      @setColor(color)
      @render()
    return @

  bind: ->
    @$body.on('click', =>
      if @status == 'stopped'
        @updateColor()
    )

  render: (duration, easing) ->
    easing ?= 'ease-in-out'
    duration ?= .2
    transition = 'background ' + duration + 's ' + easing
    @body.style.transition = transition
    @body.style.backgroundColor = @getColor()
    @color = @getColor()
    return @

module?.exports = Colorswitch
