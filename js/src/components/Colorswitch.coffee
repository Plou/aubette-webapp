# Update colors
# @param
#
# @return [Colorswitch]
class Colorswitch
  constructor: (selector) ->
    @body = document.querySelector(selector)
    @colors = require('./colors.coffee')
    @speed =
      value: 1000
      min: 300
      max: 10000

    @updateColor()
    @start()
    return @

  setSpeed: (percent) ->
    percent ?= Math.random()
    @speed.value = Math.floor((percent * (@speed.max - @speed.min)) + @speed.min)
    @updateSpeed()
    return @

  updateSpeed: ->
    @stop()
    @start()
    return @

  start: ->
    @timer = setInterval( =>
      @updateColor()
    , @speed.value )
    return @

  stop: ->
    clearInterval(@timer)
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

  render: (duration, easing) ->
    easing ?= 'ease-in-out'
    duration ?= .2
    transition = 'background ' + duration + 's ' + easing
    @body.style.transition = transition
    @body.style.backgroundColor = @getColor()
    @color = @getColor()
    return @

module?.exports = Colorswitch
