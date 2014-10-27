class SH.Views.Ship extends Marionette.ItemView
  template: JST['backbone/templates/ship']
  events:
    'click': 'selectShip'
    'mouseover': 'mouseOverShip'
    'mouseout': 'mouseOutShip'

  onShow: ->
    @$el.attr('class', "ship size_#{@model.length}")
    @$el.attr('data-state', 'inactive')
    @$el.attr('data-size', @model.length)
    @$el.attr('data-id', @model.id)
    @generateButtons()

  generateButtons: ->
    _.each [0...@model.length], (bi)=>
      button = "<button class='btn btn-default'></button>"
      @$el.append button

  selectShip: (e)=>
    e.preventDefault()
    ship = @$el
    if ship.data("state") == "inactive" && SH.State.shipSelected == false
      SH.player_playboard.highlight()
      SH.State.SelectedShip.ship = ship
      SH.State.shipSelected = true
      @toggleRotation()
      @activateShip(ship)
    else if ship.data("state") == "active"
      @deactivateShip(ship)
      SH.player_playboard.clearHighlight()
      SH.State.SelectedShip.ship = null
      SH.State.shipSelected = false
      @toggleRotation()

  mouseOverShip: ->
    return false if SH.State.shipSelected == true
    ship = @$el
    buttons = ship.find("button")
    buttons.removeClass('btn-default')
    buttons.addClass('btn-success')

  mouseOutShip: ->
    ship = @$el
    buttons = ship.find("button")
    buttons.removeClass('btn-success')
    buttons.addClass('btn-default')

  activateShip: (ship)->
    ship.data("state", "active")
    ship.find("button").removeClass('hover').addClass('selected')
    SH.State.shipSelected = true
    SH.State.SelectedShip.id = ship.data("id")
    SH.cpu_playboard.cleanPlayboard()
    $('.instructions').text("Set ship on your playboard or click the ship to deselect")

  deactivateShip: (ship)->
    ship.data("state", "inactive")
    size = ship.data("id")
    ship.find("button").removeClass('selected')
    SH.State.shipSelected = false
    SH.State.currentSelectedShipId = null
    $('.instructions').text("Click a ship to select")

  toggleRotation: (ship)->
    if SH.State.shipSelected
      $('#rotate').show()
    else
      $('#rotate').hide()
