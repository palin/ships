class SH.Views.Row extends Marionette.ItemView
  template: JST['backbone/templates/row']
  className: 'row'

  initialize: (options)->
    @rowIndex = options.rowIndex
    @rowFor = options.rowFor

  render: ->
    _.each [0..9], (ci)=>
      field = new SH.Views.Field(className: "#{@rowFor}-field", dataRow: @rowIndex, dataColumn: ci)
      f = field.render()
      @$el.append(f.$el)
