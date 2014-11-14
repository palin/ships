class SH.Models.Ship extends Backbone.Model

  fields: null
  borderFields: null

  initialize: (options)->
    @length = options.length
    @setup = options.setup
    @initialRow = options.row
    @initialColumn = options.column
    @sunk = false
    @hit = false
    @installed = false

  install: (initRow, initColumn)->
    @installed = true
    @initialRow = initRow
    @initialColumn = initColumn
    @endRow = @initialRow + (if @isHorizontal() then 0 else @length - 1)
    @endColumn = @initialColumn + (if @isHorizontal() then @length - 1 else 0)

  isHorizontal: ->
    @setup == "horizontal"

  isVertical: ->
    @setup == "vertical"

  coveredRows: ->
    return [@initialRow] if @horizontal()
    [@initialRow..@length - 1]

  coveredColumns: ->
    return [@initialColumn] if @vertical()
    [@initialColumn..@length - 1]

  rotate: ->
    @setup = if @isHorizontal() then "vertical" else "horizontal"

class SH.Collections.Ships extends Backbone.Collection