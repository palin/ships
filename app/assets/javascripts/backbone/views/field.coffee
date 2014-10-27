class SH.Views.Field extends Marionette.ItemView
  template: JST['backbone/templates/field']
  tagName: 'button'
  className: 'btn btn-default'
  events:
    'click': 'fieldClick'
    'mouseover': 'defineAction'

  initialize: (options)->
    @className = options.className
    @belongsTo = options.belongsTo
    @dataRow = options.dataRow
    @dataColumn = options.dataColumn

  onRender: ->
    @$el.attr('data-column', @dataColumn)
    @$el.attr('data-row', @dataRow)

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

  defineAction: ->
    if @belongsTo == "player" && SH.State.shipSelected == true
      @highlightShipShape()

  highlightShipShape: ->
    console.log 'highlight fields for the ship'
    # TO DO

  shoot: (field)->
    # console.log "finding a place to shoot at cpu - #{field}"
    true