class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'submitTodo',
      'toggleTodo'
    )

window.TodoActions = alt.createActions(TodoActions)
