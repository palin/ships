class SH.Services.Highlighter extends Backbone.Model

  shipColorClass: 'placing_ship'
  shipColorUnavailableClass: 'placing_ship_unavailable'

  initialize: (options)->
    @fieldsCollection = options.collection

  highlight: (options)->
    @currentField = options.currentField.model
    @currentFieldRow = @currentField.get('row')
    @currentFieldColumn = @currentField.get('column')
    @selectedShipModel = SH.State.SelectedShip.view.model
    @shipLength = @selectedShipModel.length
    @colorize()

  colorize: ->
    available = SH.Services.playboardChecker.placeIsAvailable(@currentField)
    fieldsWithinMouseRange = SH.Services.playboardChecker.allFieldsWithinMouseRange(@currentField)

    _.each fieldsWithinMouseRange, (model)=>
      cssClass = if SH.Services.playboardChecker.fieldBelongsToShip(@currentField, model)
          if available
            @shipColorClass
          else
            @shipColorUnavailableClass

      $(model.fieldView.$el).addClass(cssClass)
