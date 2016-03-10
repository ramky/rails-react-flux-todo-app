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

  submitTodo: (name) ->
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

  onToggleTodo: (todo_id) ->
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

window.TodoStore = alt.createStore(TodoStore)
