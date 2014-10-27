class SH.Views.Playboards.Player extends SH.Views.Playboard
  id: 'player'
  playboardFor: 'player'

  clean: ->
    @$('button').removeClass("placing_ship placing_ship_border")