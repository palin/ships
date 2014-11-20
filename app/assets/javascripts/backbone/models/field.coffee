class SH.Models.Field extends Backbone.Model

  initialize: (options)->
    @row = options.row
    @column = options.column
    @state = "empty"
    @for = options.for

  hasGivenCoords: (row, col)->
    @hasRow(row) && @hasColumn(col)

  hasRow: (row)->
    @get('row') == row

  hasColumn: (col)->
    @get('column') == col

  reserved: ->
    @state == "reserved"

  reserve: ->
    @state = "reserved"

  makeUnavailable: ->
    @state = "unavailable"

  unavailable: ->
    @state == "unavailable"

  empty: ->
    @state == "empty"

  hasAttributeBetween: (att, att_value_start, att_value_end)->
    @get(att) >= att_value_start && @get(att) <= att_value_end

  withinRange: (row_start, row_end, col_start, col_end)->
    @hasAttributeBetween('row', row_start, row_end) && @hasAttributeBetween('column', col_start, col_end)

  states: ["empty", "reserved", "unavailable", "shot", "hit", "missed"]

class SH.Collections.Fields extends Backbone.Collection
  findFieldByCoords: (e)->
    row = $(e.target).data('row')
    column = $(e.target).data('column')
    @findField(row, column)

  findField: (row, col)->
    _.find @models, (model)-> model.hasGivenCoords(row, col)

  findFieldsByRow: (row)->
    _.filter @models, (model)-> model.hasRow(row)

  findFieldsByColumn: (col)->
    _.filter @models, (model)-> model.hasColumn(col)

  findFieldsInRange: (row_start, row_end, col_start, col_end)->
    _.filter @models, (model)-> model.withinRange(row_start, row_end, col_start, col_end)
