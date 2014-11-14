class SH.Services.ShipInstaller extends Backbone.Model

  initialize: (options)->
    @fieldsCollection = options.collection

  install: (currentField)->
    @currentField = currentField
    @currentFieldModel = currentField.model
    @currentFieldRow = @currentFieldModel.get('row')
    @currentFieldColumn = @currentFieldModel.get('column')
    @ship = SH.State.SelectedShip.view.model
    @shipLength = @ship.length
    @reserveFields()
    @deselectShip()

  reserveFields: ->
    @reserveShipSpace()
    @makeShipBorderUnavailable()
    SH.player_playboard.clean()

  reserveShipSpace: ->
    @reserveInitialField()
    @reserveOtherFields()

  reserveInitialField: ->
    @ship.install(@currentFieldModel.get('row'), @currentFieldModel.get('column'))
    @currentFieldModel.reserve()
    @currentField.reserve()

  reserveOtherFields: ->
    shipFields = @fieldsCollection.findFieldsInRange(@ship.initialRow, @ship.endRow, @ship.initialColumn, @ship.endColumn)
    _.each shipFields, (model)->
      model.reserve()
      model.fieldView.reserve()

  makeShipBorderUnavailable: ->
    borderFields = @findAllFieldsWithinMouseRange()
    _.each borderFields, (model)=>
      if !@belongsToShip(model)
        model.makeUnavailable()
        model.fieldView.makeUnavailable()

  findAllFieldsWithinMouseRange: ->
    rowStart = @currentFieldRow - 1
    rowEnd = @currentFieldRow + (if @ship.isHorizontal() then 1 else @shipLength)

    columnStart = @currentFieldColumn - 1
    columnEnd = @currentFieldColumn + (if @ship.isHorizontal() then @shipLength else 1)

    @fieldsCollection.findFieldsInRange(rowStart, rowEnd, columnStart, columnEnd)

  belongsToShip: (field)->
    shipStartRow = @currentFieldRow
    shipEndRow = @currentFieldRow + (if @ship.isHorizontal() then 0 else @shipLength - 1)

    shipStartCol = @currentFieldColumn
    shipEndCol = @currentFieldColumn + (if @ship.isHorizontal() then @shipLength - 1 else 0)

    field.withinRange(shipStartRow, shipEndRow, shipStartCol, shipEndCol)

  deselectShip: ->
    true

  isAvailable: (currentField)->
    @currentField = currentField
    @currentFieldRow = currentField.get('row')
    @currentFieldColumn = currentField.get('column')
    @ship = SH.State.SelectedShip.view.model
    @shipLength = @ship.length
    @checkPlayboardBorder() && @checkPlayboardSpace()

  checkPlayboardBorder: ->
    playboardLength = 9
    shipBorderOffset = 2
    (playboardLength - @shipLength + shipBorderOffset) > (if @ship.isHorizontal() then @currentFieldColumn else @currentFieldRow)

  checkPlayboardSpace: ->
    !@currentField.hasShip() && !@currentField.unavailable()
