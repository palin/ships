class SH.Models.Field extends Backbone.Model

  initialize: (options)->
    @row = options.row
    @column = options.column
    @state = "empty"

  states: ["empty", "shot", "hit", "missed"]
