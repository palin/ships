window.SH =
  Views:
    Playboards: {}
  State:
    currentSelectedShipId: null
    shipSelected: false
    shipsIdsOnMap: []
    allShipsOnMap: false

$ ->
  SH.ships = new SH.Views.Ships
  SH.cpu_playboard = new SH.Views.Playboards.Cpu
  SH.player_playboards = new SH.Views.Playboards.Player
