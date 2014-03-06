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
      ship.data("state", "active")
      ship.find("button").removeClass('hover').addClass('selected')
      SH.State.shipSelected = true
      SH.State.currentSelectedShipId = ship.data("id")
      $('.instructions').text("Set ship on the CPU map or click the ship to deselect")
    else if ship.data("state") == "active"
      ship.data("state", "inactive")
      size = ship.data("id")
      ship.find("button").removeClass('selected')
      SH.State.shipSelected = false
      SH.State.currentSelectedShipId = null
      $('.instructions').text("Click a ship to select")

  mouseOverShip: (e)->
    return false if SH.State.shipSelected == true
    ship = $(e.currentTarget).parent()
    ship.find("button").addClass('hover')

  mouseOutShip: (e)->
    ship = $(e.currentTarget).parent()
    ship.find("button").removeClass('hover')
