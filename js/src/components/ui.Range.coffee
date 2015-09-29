# Manage a range controler
# @param
#
# @return [Range]
class Range
  constructor: (selector) ->
    @$input = $(selector).find('[type="range"]')
    @input = @$input.get(0)
    @_emitter = $({})
    @bind(@$input)

  setValue: (value) ->
    @input.value = value * 100
    return @

  getValue: ->
    return @input.value / 100

  trigger: (event, data) ->
    return @_emitter.trigger(event, data)

  on: (event, callback) ->
    return @_emitter.on(event, callback)

  bind: ($input) ->
    $input.on('change', (e) =>
      data = @getValue()
      @trigger('change', data)
    )
    return @

module?.exports = Range
