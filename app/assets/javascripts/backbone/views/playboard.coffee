class SH.Views.Playboard extends Marionette.CollectionView
  template: JST['backbone/templates/playboard']
  className: 'playboard'
  playboardFor: null
  itemView: SH.Views.Field

  highlight: ->
    @$el.addClass("highlighted")

  clearHighlight: ->
    @$el.removeClass("highlighted")

  disable: ->
    @$el.attr('disabled', true)
