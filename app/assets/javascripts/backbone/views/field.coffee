class SH.Views.Field extends Marionette.ItemView
  template: JST['backbone/templates/field']
  tagName: 'button'
  events:
    'click': 'handleMouseClick'
    'mouseover': 'handleMouseOver'
    'contextmenu': 'rotateShip'

  reservedClass: 'reserved'
  unavailableClass: 'unavailable'

  initialize: ->
    @model.fieldView = this

  onShow: ->
    @$el.attr('data-column', @model.get('column'))
    @$el.attr('data-row', @model.get('row'))
    @$el.attr('class', "#{@model.get('for')}-field btn btn-default")

  handleMouseClick: (e)->
    e.preventDefault()
    SH.State.clickedField = this

    if SH.State.shipSelected
      if SH.Services.playboardChecker.placeIsAvailable(this.model)
        SH.Services.shipInstaller.install(this)
        @updateState()
      else
        SH.Instructions.text("Cannot install the ship in the place you've chosen")
    else
      false

  isAvailable: ->
    !(@$el.hasClass("with_ship") || @$el.hasClass("unavailable"))

  makeUnavailable: ->
    @$el.addClass(@unavailableClass)

  reserve: ->
    @$el.addClass(@reservedClass)

  rotateShip: (e)->
    return false unless SH.State.shipSelected
    SH.State.SelectedShip.view.model.rotate()
    @highlightShipShape(e)
    return false

  handleMouseOver: (e)->
    if @model.for == "player"
      if SH.State.shipSelected == true
        @highlightShipShape()

  highlightShipShape: ->
    SH.player_playboard.clean()
    SH.Services.highlighter.highlight(currentField: this)

  updateState: ->
    SH.State.allShipsOnMap = true

    _.each SH.Ships.models, (model)->
      SH.State.allShipsOnMap = false unless model.installed

    if SH.State.allShipsOnMap
      @unlockStartButton()
      SH.Instructions.text('Click START button to start the game')

  unlockStartButton: ->
    true