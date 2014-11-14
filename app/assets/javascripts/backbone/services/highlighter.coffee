class SH.Services.Highlighter extends Backbone.Model

  initialize: (options)->
    @fieldsCollection = options.collection

  highlight: (options)->
    @currentField = options.currentField.model
    @currentFieldRow = @currentField.get('row')
    @currentFieldColumn = @currentField.get('column')
    @selectedShipView = SH.State.SelectedShip.view
    @selectedShipModel = SH.State.SelectedShip.view.model
    @shipLength = @selectedShipModel.length
    @setup = @selectedShipModel.setup

    @highlightRowBefore()
    @highlightRowMain()
    @highlightRowAfter()

  highlightRowBefore: ->
    if @setup == "horizontal" && @currentFieldRow > 0
      buttons = @findViewsButtonsByRow(@currentFieldRow - 1)

      _.each buttons, (b)=>
        buttonColumn = parseInt($(b).data('column'), 10)
        if buttonColumn >= @currentFieldColumn - 1 && buttonColumn < @currentFieldColumn + @shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

    else if @setup == "vertical" && @currentFieldColumn > 0
      buttons = @findViewsButtonsByColumn(@currentFieldColumn - 1)

      _.each buttons, (b)=>
        buttonRow = parseInt($(b).data('row'), 10)
        if buttonRow >= @currentFieldRow - 1 && buttonRow < @currentFieldRow + @shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')


  highlightRowMain: ->
    if @setup == "horizontal"
      buttons = @findViewsButtonsByRow(@currentFieldRow)

      _.each buttons, (b)=>
        buttonColumn = parseInt($(b).data('column'), 10)
        if buttonColumn >= @currentFieldColumn - 1 && buttonColumn < @currentFieldColumn + @shipLength + 1
          if buttonColumn == @currentFieldColumn - 1 || buttonColumn == @currentFieldColumn + @shipLength
            $(b).addClass('placing_ship_border')
          else
            $(b).addClass('placing_ship')
        else
          $(b).removeClass('placing_ship')

    else if @setup == "vertical"
      buttons = @findViewsButtonsByColumn(@currentFieldColumn)

      _.each buttons, (b)=>
        buttonRow = parseInt($(b).data('row'), 10)
        if buttonRow >= @currentFieldRow - 1 && buttonRow < @currentFieldRow + @shipLength + 1
          if buttonRow == @currentFieldRow - 1 || buttonRow == @currentFieldRow + @shipLength
            $(b).addClass('placing_ship_border')
          else
            $(b).addClass('placing_ship')
        else
          $(b).removeClass('placing_ship')

  highlightRowAfter: ->
    if @setup == "horizontal" && @currentFieldRow < 9
      buttons = @findViewsButtonsByRow(@currentFieldRow + 1)

      _.each buttons, (b)=>
        buttonColumn = parseInt($(b).data('column'), 10)
        if buttonColumn >= @currentFieldColumn - 1 && buttonColumn < @currentFieldColumn + @shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

    else if @setup == "vertical" && @currentFieldColumn < 9
      buttons = @findViewsButtonsByColumn(@currentFieldColumn + 1)

      _.each buttons, (b)=>
        buttonRow = parseInt($(b).data('row'), 10)
        if buttonRow >= @currentFieldRow - 1 && buttonRow < @currentFieldRow + @shipLength + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

  findViewsButtonsByRow: (row)->
    fieldModels = @fieldsCollection.findFieldsByRow(row)
    fieldViews = _.map fieldModels, (model)-> model.fieldView
    _.map fieldViews, (view)-> view.$el

  findViewsButtonsByColumn: (col)->
    fieldModels = @fieldsCollection.findFieldsByColumn(col)
    fieldViews = _.map fieldModels, (model)-> model.fieldView
    _.map fieldViews, (view)-> view.$el
