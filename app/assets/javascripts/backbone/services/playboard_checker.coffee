class SH.Services.PlayboardChecker extends Backbone.Model

  initialize: (options)->
    @fieldsCollection = options.collection

  fieldBelongsToShip: (currentField, field)->
    selectedShipModel = SH.State.SelectedShip.view.model
    shipLength = selectedShipModel.length
    currentFieldRow = currentField.row
    currentFieldColumn = currentField.column

    shipStartRow = currentFieldRow
    shipEndRow = currentFieldRow + (if selectedShipModel.isHorizontal() then 0 else shipLength - 1)

    shipStartCol = currentFieldColumn
    shipEndCol = currentFieldColumn + (if selectedShipModel.isHorizontal() then shipLength - 1 else 0)

    field.withinRange(shipStartRow, shipEndRow, shipStartCol, shipEndCol)

  allFieldsWithinMouseRange: (currentField)->
    selectedShipModel = SH.State.SelectedShip.view.model
    shipLength = selectedShipModel.length
    currentFieldRow = currentField.row
    currentFieldColumn = currentField.column

    rowStart = currentFieldRow - 1
    rowEnd = currentFieldRow + (if selectedShipModel.isHorizontal() then 1 else shipLength)

    columnStart = currentFieldColumn - 1
    columnEnd = currentFieldColumn + (if selectedShipModel.isHorizontal() then shipLength else 1)

    @fieldsCollection.findFieldsInRange(rowStart, rowEnd, columnStart, columnEnd)

  placeIsAvailable: (currentField)->
    fieldsWithinMouseRange = @allFieldsWithinMouseRange(currentField)
    @currentField = currentField
    @currentFieldRow = @currentField.row
    @currentFieldColumn = @currentField.column
    @ship = SH.State.SelectedShip.view.model
    @shipLength = @ship.length
    @shipFieldsLengthCorrect(fieldsWithinMouseRange)

  shipFieldsLengthCorrect: (fieldsWithinMouseRange)->
    placeAvailable = true
    lengthCorrect = true
    shipFields = []

    _.each fieldsWithinMouseRange, (model)=>
      shipFields.push(model) if SH.Services.playboardChecker.fieldBelongsToShip(@currentField, model)

    _.each shipFields, (model)=>
      placeAvailable = false unless model.empty()

    lengthCorrect = false if shipFields.length < @shipLength

    placeAvailable && lengthCorrect