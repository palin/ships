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

  withinRange: (row_start, row_end, col_start, col_end)->
    @get('row') >= row_start && @get('row') <= row_end &&
      @get('column') >= col_start && @get('column') <= col_end

  states: ["empty", "shot", "hit", "missed"]

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
    _.filter @models, (model)->
      model.get('row') >= row_start && model.get('row') <= row_end &&
        model.get('column') >= col_start && model.get('column') <= col_end