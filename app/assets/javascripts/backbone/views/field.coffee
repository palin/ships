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

  highlightShipShape: (field)->
    SH.player_playboard.clean()
    selectedShipView = SH.State.SelectedShip.view
    selectedShipModel = SH.State.SelectedShip.view.model
    length = selectedShipModel.length
    setup = selectedShipModel.setup

    # Highlight main row
    buttons = $('.playboard#player').find("button[data-row=#{@dataRow}]")
    _.each buttons, (b)=>
      if parseInt($(b).data('column'), 10) >= @dataColumn - 1 && parseInt($(b).data('column'), 10) < @dataColumn + length + 1
        if parseInt($(b).data('column'), 10) == @dataColumn - 1 || parseInt($(b).data('column'), 10) == @dataColumn + length
          $(b).addClass('placing_ship_border')
        else
          $(b).addClass('placing_ship')
      else
        $(b).removeClass('placing_ship')

    # Highlight row above the ship
    buttons = $('.playboard#player').find("button[data-row=#{@dataRow-1}]")
    _.each buttons, (b)=>
      try
        if parseInt($(b).data('column'), 10) >= @dataColumn - 1 && parseInt($(b).data('column'), 10) < @dataColumn + length + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')

    # Highlight row under the ship
    buttons = $('.playboard#player').find("button[data-row=#{@dataRow+1}]")
    _.each buttons, (b)=>
      try
        if parseInt($(b).data('column'), 10) >= @dataColumn - 1 && parseInt($(b).data('column'), 10) < @dataColumn + length + 1
          $(b).addClass('placing_ship_border')
        else
          $(b).removeClass('placing_ship_border')


  shoot: (field)->
    # console.log "finding a place to shoot at cpu - #{field}"
    true