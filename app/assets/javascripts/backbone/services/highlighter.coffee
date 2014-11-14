class SH.Services.Highlighter extends Backbone.Model

  shipColorClass: 'placing_ship'
  borderColorClass: 'placing_ship_border'

  initialize: (options)->
    @fieldsCollection = options.collection

  highlight: (options)->
    @currentField = options.currentField.model
    @currentFieldRow = @currentField.get('row')
    @currentFieldColumn = @currentField.get('column')
    @selectedShipModel = SH.State.SelectedShip.view.model
    @shipLength = @selectedShipModel.length
    @fieldsWithinMouseRange = @findAllFieldsWithinMouseRange()
    @colorize()

  findAllFieldsWithinMouseRange: ->
    rowStart = @currentFieldRow - 1
    rowEnd = @currentFieldRow + (if @selectedShipModel.isHorizontal() then 1 else @shipLength)

    columnStart = @currentFieldColumn - 1
    columnEnd = @currentFieldColumn + (if @selectedShipModel.isHorizontal() then @shipLength else 1)

    @fieldsCollection.findFieldsInRange(rowStart, rowEnd, columnStart, columnEnd)

  belongsToShip: (field)->
    shipStartRow = @currentFieldRow
    shipEndRow = @currentFieldRow + (if @selectedShipModel.isHorizontal() then 0 else @shipLength - 1)

    shipStartCol = @currentFieldColumn
    shipEndCol = @currentFieldColumn + (if @selectedShipModel.isHorizontal() then @shipLength - 1 else 0)

    field.withinRange(shipStartRow, shipEndRow, shipStartCol, shipEndCol)

  colorize: ->
    _.each @fieldsWithinMouseRange, (model)=>
      cssClass = if @belongsToShip(model) then @shipColorClass else @borderColorClass
      $(model.fieldView.$el).addClass(cssClass)
