class SH.Views.Ship extends Marionette.ItemView
  template: JST['backbone/templates/ship']
  events:
    'click': 'clickShip'
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

  clickShip: (e)=>
    e.preventDefault()
    @toggleShipSelection()

  toggleShipSelection: (destroyShip=false)->
    ship = @$el
    if ship.data("state") == "inactive" && SH.State.shipSelected == false
      SH.playerPlayboard.highlight()
      SH.State.SelectedShip.view = this
      SH.State.shipSelected = true
      @activateShip(ship)
    else if ship.data("state") == "active"
      SH.playerPlayboard.clean()
      @deactivateShip(ship)
      SH.playerPlayboard.clearHighlight()
      SH.State.SelectedShip.view = null
      SH.State.shipSelected = false
      ship.remove() if destroyShip

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
    SH.State.SelectedShip.view = this
    SH.Instructions.text("Set the ship on your playboard with LMB, rotate over playboard with RMB, click the ship again to deselect")

  deactivateShip: (ship)->
    ship.data("state", "inactive")
    size = ship.data("id")
    ship.find("button").removeClass('selected')
    SH.State.shipSelected = false
    SH.State.currentSelectedShipId = null
    SH.Instructions.text("Click a ship to select")
