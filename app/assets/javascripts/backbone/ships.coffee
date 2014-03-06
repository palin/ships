window.Ships =
  Views:
    Playboards: {}

$ ->
  Ships.ships = new Ships.Views.Ships
  Ships.cpu_playboard = new Ships.Views.Playboards.Cpu
  Ships.player_playboards = new Ships.Views.Playboards.Player
