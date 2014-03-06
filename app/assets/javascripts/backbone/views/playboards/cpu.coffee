class Ships.Views.Playboards.Cpu extends Marionette.ItemView

  el: "#cpu.playboard"
  events:
    'click button': 'shoot'
    'mouseover button': 'showGrids'

  hit: ->
    false

  shoot: (e)->
    row = $(e.currentTarget).data("row")
    column = $(e.currentTarget).data("column")
    if @hit()
      $(e.currentTarget).addClass("hit")
    else
      $(e.currentTarget).addClass("empty")

  showGrids: (e)->
    row = $(e.currentTarget).data("row")
    column = $(e.currentTarget).data("column")
    rows_to_select = [0..row-1]
    columns_to_select = [0..column-1]
    _.each @$("button"), (button)->
      b_row = $(button).data("row")
      b_col = $(button).data("column")
      if (_.include(rows_to_select, b_row) && b_col == column && !_.include(rows_to_select, -1)) || (_.include(columns_to_select, b_col) && b_row == row && !_.include(columns_to_select, -1))
        $(button).addClass("selected")
      else
        $(button).removeClass("selected")
