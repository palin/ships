class SH.Views.Playboard extends Marionette.CollectionView
  template: JST['backbone/templates/playboard']
  className: 'playboard'
  playboardFor: null
  itemView: SH.Views.Row

  initialize: ->
    @rows = []

  onShow: ->
    @generateRows()

  highlight: ->
    @$el.addClass("highlighted")

  clearHighlight: ->
    @$el.removeClass("highlighted")

  generateRows: ->
    _.each [0..9], (ri)=>
      row = new SH.Views.Row(rowFor: @playboardFor, rowIndex: ri)
      row.render()
      @$el.append(row.$el)
      @rows.push(row)
