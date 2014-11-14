class SH.Views.Playboard extends Marionette.CollectionView
  template: JST['backbone/templates/playboard']
  className: 'playboard'
  playboardFor: null
  itemView: SH.Views.Field

  events:
    'mouseover': 'defineAction'
    'contextmenu': 'rotateShip'

  highlight: ->
    @$el.addClass("highlighted")

  clearHighlight: ->
    @$el.removeClass("highlighted")

  rotateShip: (e)->
    return false unless SH.State.shipSelected
    SH.State.SelectedShip.view.model.rotate()
    @highlightShipShape(e)
    return false

  defineAction: (e)->
    @highlightShipShape(e) if @playboardFor == "player" && SH.State.shipSelected == true

  highlightShipShape: (e)->
    currentField = @collection.findFieldByCoords(e)
    if currentField
      SH.player_playboard.clean()
      selectedShipView = SH.State.SelectedShip.view
      selectedShipModel = SH.State.SelectedShip.view.model
      shipLength = selectedShipModel.length
      setup = selectedShipModel.setup

      @highlightRowBefore(setup, shipLength, currentField)
      @highlightRowMain(setup, shipLength, currentField)
      @highlightRowAfter(setup, shipLength, currentField)

  highlightRowBefore: (setup, shipLength, currentField)->
    mouseRow = currentField.get('row')
    mouseColumn = currentField.get('column')

    if setup == "horizontal" && mouseRow > 0
      buttons = @findViewsButtonsByRow(mouseRow - 1)

      _.each buttons, (b)=>
        buttonColumn = parseInt($(b).data('column'), 10)
        if buttonColumn >= mouseColumn - 1 && buttonColumn < mouseColumn + shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

    else if setup == "vertical" && mouseColumn > 0
      buttons = @findViewsButtonsByColumn(mouseColumn - 1)

      _.each buttons, (b)=>
        buttonRow = parseInt($(b).data('row'), 10)
        if buttonRow >= mouseRow - 1 && buttonRow < mouseRow + shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')


  highlightRowMain: (setup, shipLength, currentField)->
    mouseRow = currentField.get('row')
    mouseColumn = currentField.get('column')

    if setup == "horizontal"
      buttons = @findViewsButtonsByRow(mouseRow)

      _.each buttons, (b)=>
        buttonColumn = parseInt($(b).data('column'), 10)
        if buttonColumn >= mouseColumn - 1 && buttonColumn < mouseColumn + shipLength + 1
          if buttonColumn == mouseColumn - 1 || buttonColumn == mouseColumn + shipLength
            $(b).addClass('placing_ship_border')
          else
            $(b).addClass('placing_ship')
        else
          $(b).removeClass('placing_ship')

    else if setup == "vertical"
      buttons = @findViewsButtonsByColumn(mouseColumn)

      _.each buttons, (b)=>
        buttonRow = parseInt($(b).data('row'), 10)
        if buttonRow >= mouseRow - 1 && buttonRow < mouseRow + shipLength + 1
          if buttonRow == mouseRow - 1 || buttonRow == mouseRow + shipLength
            $(b).addClass('placing_ship_border')
          else
            $(b).addClass('placing_ship')
        else
          $(b).removeClass('placing_ship')

  highlightRowAfter: (setup, shipLength, currentField)->
    mouseRow = currentField.get('row')
    mouseColumn = currentField.get('column')

    if setup == "horizontal" && mouseRow < 9
      buttons = @findViewsButtonsByRow(mouseRow + 1)

      _.each buttons, (b)=>
        buttonColumn = parseInt($(b).data('column'), 10)
        if buttonColumn >= mouseColumn - 1 && buttonColumn < mouseColumn + shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

    else if setup == "vertical" && mouseColumn < 9
      buttons = @findViewsButtonsByColumn(mouseColumn + 1)

      _.each buttons, (b)=>
        buttonRow = parseInt($(b).data('row'), 10)
        if buttonRow >= mouseRow - 1 && buttonRow < mouseRow + shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

  findViewsButtonsByRow: (row)->
    fieldModels = @collection.findFieldsByRow(row)
    fieldViews = _.map fieldModels, (model)-> model.fieldView
    _.map fieldViews, (view)-> view.$el

  findViewsButtonsByColumn: (col)->
    fieldModels = @collection.findFieldsByColumn(col)
    fieldViews = _.map fieldModels, (model)-> model.fieldView
    _.map fieldViews, (view)-> view.$el
