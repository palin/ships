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
      @activateShip(ship)
    else if ship.data("state") == "active"
      @deactivateShip(ship)

  mouseOverShip: (e)->
    return false if SH.State.shipSelected == true
    ship = $(e.currentTarget).parent()
    ship.find("button").addClass('hover')

  mouseOutShip: (e)->
    ship = $(e.currentTarget).parent()
    ship.find("button").removeClass('hover')

  activateShip: (ship)->
    ship.data("state", "active")
    ship.find("button").removeClass('hover').addClass('selected')
    SH.State.shipSelected = true
    SH.State.currentSelectedShipId = ship.data("id")
    SH.cpu_playboard.cleanPlayboard()
    $('.instructions').text("Set ship on the CPU map or click the ship to deselect")

  deactivateShip: (ship)->
    ship.data("state", "inactive")
    size = ship.data("id")
    ship.find("button").removeClass('selected')
    SH.State.shipSelected = false
    SH.State.currentSelectedShipId = null
    $('.instructions').text("Click a ship to select")
