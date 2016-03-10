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
          checked: false
      success: (response) =>
        @todos.push(response)
        @emitChange()
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

  toggleTodo: (todo_id) ->
    $.ajax
      type: 'PUT'
      url: "todos/#{todo_id}"
      success: (response) =>
        _.find(@todos, { id: response.id }).checked = response.checked
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
        console.log(todo_id)
        @emitChange()
      error: (response) ->
        console.log('error')
        console.log(response)
    return false

window.TodoStore = alt.createStore(TodoStore)
