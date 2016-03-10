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

window.TodoStore = alt.createStore(TodoStore)
