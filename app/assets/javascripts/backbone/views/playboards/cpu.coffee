class SH.Views.Playboards.Cpu extends SH.Views.Playboard
  id: 'cpu'
  playboardFor: 'cpu'
  events:
    'mouseover button': 'mouseOverButton'

  mouseOverButton: (e)->
    ship = SH.State.SelectedShip.ship
    currentRow = $(e.currentTarget).data("row")
    currentColumn = $(e.currentTarget).data("column")
    if SH.State.shipSelected == true
      @drawShipShape(ship, currentRow, currentColumn)
    else
      @drawGridLines(ship, currentRow, currentColumn)

  drawGridLines: (ship, row, column)->
    rows_to_select = [0..row-1]
    columns_to_select = [0..column-1]
    _.each @$("button"), (button)->
      b_row = $(button).data("row")
      b_col = $(button).data("column")
      if (_.include(rows_to_select, b_row) && b_col == column && !_.include(rows_to_select, -1)) || (_.include(columns_to_select, b_col) && b_row == row && !_.include(columns_to_select, -1))
        $(button).addClass("selected")
      else
        $(button).removeClass("selected")

  cleanPlayboard: ->
    @$('button').removeClass("selected")

  drawShipShape: (ship, row, column)->
    shipLength = ship.data("size")
    shipDirection = "horizontal"
    if shipDirection == "horizontal"
      rows_to_select = [row]
      columns_to_select = [column..column+shipLength-1]
    else if shipDirection == "vertical"
      rows_to_select = [row..row+shipLength-1]
      columns_to_select = [column]

    console.log rows_to_select
    console.log columns_to_select

    _.each @rows, (rows_row)=>
      if _.include(rows_to_select, rows_row.rowIndex)
        _.each rows_row.fields, (field)=>
          if _.include(columns_to_select, field.dataColumn)
            if @canPlaceShip(row, column, shipLength, shipDirection, field)
              field.$el.addClass('placing_ship')
            else
              field.$el.addClass('unavailable')
          else
            field.$el.removeClass('placing_ship')
            field.$el.removeClass('unavailable')
      else
        _.each rows_row.fields, (field)->
          field.$el.removeClass('placing_ship')
          field.$el.removeClass('unavailable')
    true

  canPlaceShip: (row, column, length, direction, field)->
    return false if field.hasClass("unavailable") || field.hasClass("with_ship")

  installShip: (e)->
    field = SH.State.clickedField
    ship = SH.State.SelectedShip.ship
    # if @canPlaceShip(field.dataRow, field.dataColumn, ship.length, ship.setup, field)
