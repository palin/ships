class SH.Services.ShipInstaller extends Backbone.Model

  initialize: (options)->
    @fieldsCollection = options.collection

  install: (currentField)->
    @currentField = currentField
    @currentFieldModel = currentField.model
    @ship = SH.State.SelectedShip.view.model
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
    @ship.install(@currentFieldModel.row, @currentFieldModel.column)
    @currentFieldModel.reserve()
    @currentField.reserve()

  reserveOtherFields: ->
    shipFields = @fieldsCollection.findFieldsInRange(@ship.initialRow, @ship.endRow, @ship.initialColumn, @ship.endColumn)
    _.each shipFields, (model)->
      model.reserve()
      model.fieldView.reserve()

  makeShipBorderUnavailable: ->
    borderFields = SH.Services.playboardChecker.allFieldsWithinMouseRange(@currentFieldModel)
    _.each borderFields, (model)=>
      model.makeUnavailable() unless SH.Services.playboardChecker.fieldBelongsToShip(@currentFieldModel, model)

  deselectShip: ->
    SH.State.SelectedShip.view.toggleShipSelection(true)
