class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'submitTodo',
      'toggleTodo'
      'deleteTodo'
    )

window.TodoActions = alt.createActions(TodoActions)
