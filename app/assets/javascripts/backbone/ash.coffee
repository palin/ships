window.SH =
  Models: {}
  Views:
    Playboards: {}
  Collections: {}
  Services: {}

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
    cpu_fields = new SH.Collections.Fields(@createFields('cpu'))
    SH.cpu_playboard = new SH.Views.Playboards.Cpu(collection: cpu_fields)
    region = new Marionette.Region(el: $("#container #right"))
    region.show(SH.cpu_playboard)

    player_fields = new SH.Collections.Fields(@createFields('player'))
    player_highlighter = new SH.Services.Highlighter(collection: player_fields)
    SH.player_playboard_highlighter = player_highlighter
    SH.player_playboard = new SH.Views.Playboards.Player(collection: player_fields)
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

  createFields: (fieldsFor)->
    fields = []
    _.each [0..9], (ri)=>
      _.each [0..9], (ci)=>
        fields.push(new SH.Models.Field(row: ri, column: ci, for: fieldsFor))
    fields

$ ->
  SH.attachPlayboards()
  SH.createShips()
  SH.attachShips()

