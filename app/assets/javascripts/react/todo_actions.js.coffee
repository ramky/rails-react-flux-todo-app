class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'createTodo',
      'toggleTodo'
      'deleteTodo'
    )

window.TodoActions = alt.createActions(TodoActions)
