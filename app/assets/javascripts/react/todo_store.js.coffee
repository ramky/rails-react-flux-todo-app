class TodoStore
  @displayName: 'TodoStore'

  constructor: ->
    @bindActions(TodoActions)
    @todos = []

    @exportPublicMethods(
      {
        getTodos: @getTodos
      }
    )

  onInitData: (props) ->
    @todos = props.todos

  getTodos: () ->
    @getState().todos

  createTodo: (name) ->
    $.ajax
      type: 'POST'
      url: '/todos'
      data:
        todo:
          name: name
          completed: false
      success: (response) =>
        @todos.push(response)
        @emitChange()
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

  refreshTodo: (todo) ->
    _.find(@todos, { id: todo.id }).name = todo.name
    @emitChange()
    return false

  updateTodo: (todo) ->
    $.ajax
      type: 'PUT'
      url: "update_name/#{todo.id}"
      data: { name: todo.name }
      success: (response) =>
        console.log('ok')
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

  toggleTodo: (todoId) ->
    $.ajax
      type: 'PUT'
      url: "update_completed/#{todoId}"
      success: (response) =>
        _.find(@todos, { id: response.id }).completed = response.completed
        @emitChange()
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

  deleteTodo: (todo_id) ->
    $.ajax
      type: 'DELETE'
      url: "todos/#{todo_id}"
      success: (response) =>
        _.remove(@todos, (todo) -> todo.id == todo_id)
        @emitChange()
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

  clearCompleted: ->
    $.ajax
      type: 'DELETE'
      url: '/clear_completed'
      success: (response) =>
        _.remove(@todos, (todo) -> todo.completed == true)
        @emitChange()
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

window.TodoStore = alt.createStore(TodoStore)
