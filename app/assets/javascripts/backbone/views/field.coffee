class SH.Views.Field extends Marionette.ItemView
  template: JST['backbone/templates/field']
  tagName: 'button'
  events:
    'click': 'fieldClick'
    'mouseover': 'defineAction'
    'contextmenu': 'rotateShip'

  initialize: ->
    @model.fieldView = this

  onShow: ->
    @$el.attr('data-column', @model.get('column'))
    @$el.attr('data-row', @model.get('row'))
    @$el.attr('class', "#{@model.get('for')}-field btn btn-default")

  fieldClick: (e)->
    e.preventDefault()
    SH.State.clickedField = this
    if SH.State.shipSelected
      SH.player_playboard.installShip(e)

  isAvailable: ->
    !(@$el.hasClass("with_ship") || @$el.hasClass("unavailable"))

  rotateShip: (e)->
    return false unless SH.State.shipSelected
    SH.State.SelectedShip.view.model.rotate()
    @highlightShipShape(e)
    return false

  defineAction: (e)->
    if @model.for == "player"
      if SH.State.shipSelected == true
        @highlightShipShape()

  highlightShipShape: ->
    SH.player_playboard.clean()
    SH.Services.highlighter.highlight(currentField: this)