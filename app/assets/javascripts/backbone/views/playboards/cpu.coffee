class SH.Views.Playboards.Cpu extends SH.Views.Playboard
  id: 'cpu'
  playboardFor: 'cpu'
  events:
    'click button': 'shoot'
    'mouseover button': 'mouseOverButton'

  hit: ->
    false

  shoot: (e)->
    row = $(e.currentTarget).data("row")
    column = $(e.currentTarget).data("column")
    if @hit()
      $(e.currentTarget).addClass("hit")
    else
      $(e.currentTarget).addClass("empty")

  mouseOverButton: (e)->
    ship = $(e.currentTarget).parent()
    currentRow = $(e.currentTarget).data("row")
    currentColumn = $(e.currentTarget).data("column")
    if SH.State.shipSelected == true
      @showShipShape(ship, currentRow, currentColumn)
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

  showShipShape: (ship, row, column)->
    console.log ship
    shipLength = ship.data("size")
    console.log shipLength
    true

  drawShip: (e)->
