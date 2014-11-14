class SH.Views.Field extends Marionette.ItemView
  template: JST['backbone/templates/field']
  tagName: 'button'
  events:
    'click': 'fieldClick'

  initialize: ->
    @model.fieldView = this

  onShow: ->
    @$el.attr('data-column', @model.get('column'))
    @$el.attr('data-row', @model.get('row'))
    @$el.attr('class', "#{@model.get('for')}-field btn btn-default")

  hit: ->
    false

  fieldClick: (e)->
    e.preventDefault()
    SH.State.clickedField = this
    if SH.State.shipSelected
      SH.cpu_playboard.installShip(e)
    else
      @shoot(e)

  shoot: (e)->
    target = $(e.currentTarget)
    row = target.data("row")
    column = target.data("column")
    if @hit()
      target.addClass("hit")
    else
      target.removeClass('btn-default')
      target.addClass('btn-info')
      target.addClass("empty")

  isAvailable: ->
    !(@$el.hasClass("with_ship") || @$el.hasClass("unavailable"))

  shoot: (field)->
    true