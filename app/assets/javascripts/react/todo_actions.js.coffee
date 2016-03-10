class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'submitTodo'
    )

window.TodoActions = alt.createActions(TodoActions)
