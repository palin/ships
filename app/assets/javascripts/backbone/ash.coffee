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
  Instructions: null

  initInstructions: ->
    SH.Instructions = $('.instructions').text('Click a ship to select')

  attachPlayboards: ->
    cpu_fields = new SH.Collections.Fields(@createFields('cpu'))
    SH.cpu_playboard = new SH.Views.Playboards.Cpu(collection: cpu_fields)
    region = new Marionette.Region(el: $("#container #right"))
    region.show(SH.cpu_playboard)

    player_fields = new SH.Collections.Fields(@createFields('player'))
    SH.Services.shipInstaller = new SH.Services.ShipInstaller(collection: player_fields)
    SH.Services.highlighter = new SH.Services.Highlighter(collection: player_fields)
    SH.Services.playboardChecker = new SH.Services.PlayboardChecker(collection: player_fields)
    SH.playerPlayboard = new SH.Views.Playboards.Player(collection: player_fields)
    region = new Marionette.Region(el: $("#container #left"))
    region.show(SH.playerPlayboard)

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
  SH.initInstructions()
  SH.attachPlayboards()
  SH.createShips()
  SH.attachShips()

