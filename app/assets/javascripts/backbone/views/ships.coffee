class SH.Views.Ships extends Marionette.ItemView
  el: "#ships"
  events:
    'click .ship': 'selectShip'
    'mouseover button': 'mouseOverShip'
    'mouseout button': 'mouseOutShip'

  selectShip: (e)=>
    e.preventDefault()
    ship = $(e.currentTarget)
    if ship.data("state") == "inactive" && SH.State.shipSelected == false
      SH.cpu_playboard.highlight()
      SH.State.SelectedShip.ship = ship
      @activateShip(ship)
    else if ship.data("state") == "active"
      @deactivateShip(ship)
      SH.cpu_playboard.clearHighlight()
      SH.State.SelectedShip.ship = null

  mouseOverShip: (e)->
    return false if SH.State.shipSelected == true
    ship = $(e.currentTarget).parent()
    buttons = ship.find("button")
    buttons.removeClass('btn-default')
    buttons.addClass('btn-success')

  mouseOutShip: (e)->
    ship = $(e.currentTarget).parent()
    buttons = ship.find("button")
    buttons.removeClass('btn-success')
    buttons.addClass('btn-default')

  activateShip: (ship)->
    ship.data("state", "active")
    ship.find("button").removeClass('hover').addClass('selected')
    SH.State.shipSelected = true
    SH.State.SelectedShip.id = ship.data("id")
    SH.cpu_playboard.cleanPlayboard()
    $('.instructions').text("Set ship on the CPU map or click the ship to deselect")

  deactivateShip: (ship)->
    ship.data("state", "inactive")
    size = ship.data("id")
    ship.find("button").removeClass('selected')
    SH.State.shipSelected = false
    SH.State.currentSelectedShipId = null
    $('.instructions').text("Click a ship to select")
