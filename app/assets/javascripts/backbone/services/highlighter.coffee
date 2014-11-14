class SH.Services.Highlighter extends Backbone.Model

  initialize: (options)->
    @fieldsCollection = options.collection

  highlight: (options)->
    @currentField = options.currentField.model
    @currentFieldRow = @currentField.get('row')
    @currentFieldColumn = @currentField.get('column')
    @selectedShipModel = SH.State.SelectedShip.view.model
    @shipLength = @selectedShipModel.length
    @setup = @selectedShipModel.setup
    @draw()

  findAllFieldsWithinRange: ->
    rowStart = @currentFieldRow - 1
    rowEnd = @currentFieldRow + (if @setup == "horizontal" then 1 else @shipLength)

    columnStart = @currentFieldColumn - 1
    columnEnd = @currentFieldColumn + (if @setup == "horizontal" then @shipLength else 1)

    @fieldsCollection.findFieldsInRange(rowStart, rowEnd, columnStart, columnEnd)

  belongsToShip: (field)->
    shipStartRow = @currentFieldRow
    shipEndRow = @currentFieldRow + (if @setup == "horizontal" then 0 else @shipLength - 1)

    shipStartCol = @currentFieldColumn
    shipEndCol = @currentFieldColumn + (if @setup == "horizontal" then @shipLength - 1 else 0)

    field.withinRange(shipStartRow, shipEndRow, shipStartCol, shipEndCol)

  belongsToShipBorder: (field)->
    !@belongsToShip(field)

  draw: ->
    fieldModels = @findAllFieldsWithinRange()
    _.each fieldModels, (model)=>
      if @belongsToShip(model)
        $(model.fieldView.$el).addClass('placing_ship')
      else
        $(model.fieldView.$el).addClass('placing_ship_border')