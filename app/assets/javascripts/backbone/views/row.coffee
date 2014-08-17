class SH.Views.Row extends Marionette.ItemView
  template: JST['backbone/templates/row']
  className: 'row'

  initialize: (options)->
    @rowIndex = options.rowIndex
    @rowFor = options.rowFor
    @fields = []

  render: ->
    _.each [0..9], (ci)=>
      field = new SH.Views.Field(className: "#{@rowFor}-field btn btn-default", dataRow: @rowIndex, dataColumn: ci)
      field.render()
      @$el.append(field.$el)
      @fields.push field

  checkIfAvailable: (column, shipLength)->
    [column..column + shipLength - 1]
    _.all @fields, (field)-> field.isAvailable()
