# Manage Ui
# @param
#
# @return [Ui]

Range = require('./ui.Range.coffee')
Popin = require('./Popin.coffee')


class Ui
  constructor: (selector, screens) ->
    @setScreens(screens)
    @switchScreen(screens[0].id)
    @setControls(selector)
    @popin = new Popin()
    @switchMode('auto')
    @bindControls()
    return @

  setControls: (selector) ->
    @controlBox = $(selector)
    @controls = @controlBox.find('.ui-control')
    @control =
      range: new Range('[data-action="ui-range"]')
    return @

  setScreens: (screens) ->
    @screens = []
    @screenIds = []
    for screen in screens
      @screenIds.push(screen.id)
      @screens[screen.id] = new screen.class(screen.selector)
      @screens[screen.id].hide()
    return @


  start: ->
    @screen.start()
    return @

  stop: ->
    @screen.stop()
    return @

  switchScreen: (id) ->
    if @screen?
      @screen.hide()
      speed = @screen.getSpeedRatio()

    @screen = @screens[id]
    @screenCurrent = id
    if speed?
      @screen.setSpeed(speed)

    @screen.show()

    if @mode == 'manual'
      @setManual()
    return @

  toggleScreen: ->
    @switchScreen(if @screenCurrent == 'mondrian' then 'color' else 'mondrian')
    return @

  setAuto: ->
    @mode = 'auto'
    @do()['ui-random']()
    @controlBox.addClass('ui-isauto')
    return @

  setManual: ->
    @mode = 'manual'
    @stop()
    @controlBox.removeClass('ui-isauto')
    return @

  toggleMode: ->
    @switchMode(if @mode == 'manual' then 'auto' else 'manual')
    return @


  switchMode: (mode) ->
    switch mode
      when 'auto'
        @setAuto()
        break
      when 'manual'
        @setManual()
        break
    return @

  getAction: ($el) ->
    action = $el.attr('data-action')
    return action

  getType: ($el) ->
    type = $el.attr('data-type')
    return type

  getValue:
    'ui-push': ->
      return true

      # Depracated
    'ui-range': ($el) ->
      return

    'ui-switch': ($el) ->
      value = 'switch'
      return value

  do: ->
    return {
      'ui-help': =>
        @popin.toggle()
        return @

      'ui-random': =>
        @screen.setSpeed()
        @control.range.setValue(@screen.getSpeedRatio())
        return @

      # Depracated
      'ui-range': (value) ->
        return

      'ui-control-switch': =>
        @toggleMode()
        return @

      'ui-screen-switch': =>
        @toggleScreen()
        return @
    }

  bindControls: ->
    @control.range.on('change', (e, value) =>
      @screen.setSpeed(value)
    )
    @controls.on('click', (e) =>
      if $(e.target).not('.ui-prevent-click').length
        $control = $(e.target).closest('.ui-control')
        action = @getAction($control)
        type = @getType($control)
        value = @getValue[type]($control)
        @do()[action](value)
    )
    return @

module?.exports = Ui
