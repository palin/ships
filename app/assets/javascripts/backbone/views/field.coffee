class SH.Views.Field extends Marionette.ItemView
  template: JST['backbone/templates/field']
  tagName: 'button'

  initialize: (options)->
    @className = options.className
    @dataRow = options.dataRow
    @dataColumn = options.dataColumn

  onRender: ->
    @$el.attr('data-column', @dataColumn)
    @$el.attr('data-row', @dataRow)
