window.SH =
  Models: {}
  Views:
    Playboards: {}

  State:
    SelectedShip:
      id: null
      ship: null
    shipSelected: false
    shipsIdsOnMap: []
    allShipsOnMap: false
    clickedField: null

  attachPlayboards: ->
    SH.cpu_playboard = new SH.Views.Playboards.Cpu
    region = new Marionette.Region(el: $("#container #right"))
    region.show(SH.cpu_playboard)

    SH.player_playboard = new SH.Views.Playboards.Player
    region = new Marionette.Region(el: $("#container #left"))
    region.show(SH.player_playboard)

  attachShips: ->
    SH.ships = new SH.Views.Ships

$ ->
  SH.attachPlayboards()
  SH.attachShips()
