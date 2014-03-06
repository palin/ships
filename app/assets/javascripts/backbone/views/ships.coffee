class Ships.Views.Ships extends Marionette.ItemView

  el: "#ships"

  events:
    'click .ship': 'selectShip'
    'mouseover button': 'hoverShip'
    'mouseout button': 'outShip'

  selectShip: (e)->
    e.preventDefault()
    button = $(e.currentTarget)
    button.data("state", "active")

  hoverShip: (e)->
    size = $(e.currentTarget).data("id")
    $("button[data-id='#{size}'").addClass('hover')

  outShip: (e)->
    size = $(e.currentTarget).data("id")
    $("button[data-id='#{size}'").removeClass('hover')
