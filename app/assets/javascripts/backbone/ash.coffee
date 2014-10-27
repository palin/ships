window.SH =
  Models: {}
  Views:
    Playboards: {}
  Collections: {}

  State:
    SelectedShip:
      id: null
      view: null
    shipSelected: false
    shipsIdsOnMap: []
    allShipsOnMap: false
    clickedField: null

  Ships: null

  attachPlayboards: ->
    SH.cpu_playboard = new SH.Views.Playboards.Cpu
    region = new Marionette.Region(el: $("#container #right"))
    region.show(SH.cpu_playboard)

    SH.player_playboard = new SH.Views.Playboards.Player
    region = new Marionette.Region(el: $("#container #left"))
    region.show(SH.player_playboard)

  attachShips: ->
    shipsView = new SH.Views.Ships(collection: SH.Ships)
    region = new Marionette.Region(el: $("#ships"))
    region.show(shipsView)

  createShips: ->
    ships = []
    shipsIdSize = { 5: 5, 4: 4, 3: 3, 2: 3, 1: 2}

    _.each shipsIdSize, (value, key)->
      ship = new SH.Models.Ship(id: key, length: value, setup: 'horizontal')
      ships.push(ship)
    SH.Ships = new SH.Collections.Ships(ships)

$ ->
  SH.attachPlayboards()
  SH.createShips()
  SH.attachShips()
