# Manage Ui
# @param
#
# @return [Ui]

Range = require('./ui.Range.coffee')
Popin = require('./Popin.coffee')


class Ui
  constructor: (selector, Interface, interfaceSelector) ->
    @interface = new Interface(interfaceSelector)
    @setControls(selector)
    @popin = new Popin('<h1>help!</h1>')
    @switch('auto')
    @bindControls()
    return @

  setControls: (selector) ->
    @controlBox = $(selector)
    @controls = @controlBox.find('.ui-control')
    @control =
      range: new Range('[data-action="ui-range"]')
    return @

  start: ->
    @interface.start()
    return @

  stop: ->
    @interface.stop()
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
    @switch(if @mode == 'manual' then 'auto' else 'manual')
    return @

  switch: (mode) ->
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

    'ui-range': ($el) ->
      return $el.find('[type=range]').get(0).value / 100

    'ui-switch': ($el) ->
      value = 'switch'
      return value

  do: ->
    return {
      'ui-help': =>
        @popin.toggle()
        return @

      'ui-random': =>
        @interface.setSpeed()
        @control.range.setValue(@interface.getSpeedRatio())
        return @

      # Depracated
      'ui-range': (value) =>
        return @

      'ui-switch': =>
        @toggleMode()
        return @
    }

  bindControls: ->
    @control.range.on('change', (e, value) =>
      @interface.setSpeed(value)
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
