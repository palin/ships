class SH.Views.Playboard extends Marionette.Layout
  template: JST['backbone/templates/playboard']
  className: 'playboard'
  playboardFor: null

  initialize: ->
    @rows = []

  onShow: ->
    _.each [0..9], (ri)=>
      row = new SH.Views.Row(rowFor: @playboardFor, rowIndex: ri)
      row.render()
      @$el.append(row.$el)
      @rows.push row
