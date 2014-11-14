class SH.Services.Highlighter extends Backbone.Model

  shipColorClass: 'placing_ship'
  shipColorUnavailableClass: 'placing_ship_unavailable'
  borderColorClass: 'placing_ship_border'
  borderColorUnavailableClass: 'placing_ship_border_unavailable'

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

  requiredFieldsCount: ->
    (@shipLength + 2) * 3

  colorize: ->
    _.each @fieldsWithinMouseRange, (model)=>
      cssClass = if @belongsToShip(model)
          if SH.Services.shipInstaller.isAvailable(@currentField)
            @shipColorClass
          else
            @shipColorUnavailableClass
        else
          if SH.Services.shipInstaller.isAvailable(@currentField)
            @borderColorClass
          else
            @borderColorUnavailableClass

      $(model.fieldView.$el).addClass(cssClass)
