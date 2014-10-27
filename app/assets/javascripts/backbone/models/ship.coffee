class SH.Models.Ship extends Backbone.Model

  fields: null

  initialize: (options)->
    @length = options.length
    @setup = options.setup
    @initialRow = options.row
    @initialColumn = options.column
    @sunk = false
    @hit = false

  horizontal: ->
    @setup == "horizontal"

  vertical: ->
    @setup == "vertical"

  coveredRows: ->
    return [@initialRow] if @horizontal()
    [@initialRow..@length - 1]

  coveredColumns: ->
    return [@initialColumn] if @vertical()
    [@initialColumn..@length - 1]

class SH.Collections.Ships extends Backbone.Collection