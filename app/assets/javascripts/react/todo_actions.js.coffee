class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'createTodo',
      'refreshTodo',
      'updateTodo',
      'toggleTodo',
      'deleteTodo',
      'clearCompleted'
    )

window.TodoActions = alt.createActions(TodoActions)
