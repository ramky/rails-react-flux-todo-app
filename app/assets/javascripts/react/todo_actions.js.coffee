class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'createTodo',
      'toggleTodo',
      'deleteTodo',
      'clearCompleted'
    )

window.TodoActions = alt.createActions(TodoActions)
