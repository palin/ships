class SH.Views.Playboard extends Marionette.CollectionView
  template: JST['backbone/templates/playboard']
  className: 'playboard'
  playboardFor: null
  itemView: SH.Views.Row
  events:
    'mouseover .cpu-field': 'placeShip'

  initialize: ->
    @rows = []

  onShow: ->
    _.each [0..9], (ri)=>
      row = new SH.Views.Row(rowFor: @playboardFor, rowIndex: ri)
      row.render()
      @$el.append(row.$el)
      @rows.push(row)

  highlight: ->
    @$el.addClass("highlighted")

  clearHighlight: ->
    @$el.removeClass("highlighted")
