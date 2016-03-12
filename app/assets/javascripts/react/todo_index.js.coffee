{ div, h1, ul, li, a, span, label, input, button, i } = React.DOM

NewTodo = React.createFactory React.createClass
  getInitialState: ->
    return { name: '', completed: false }

  onInputChange: (e) ->
    @setState({ name: e.target.value, completed: false })

  onInputKeydown: (e) ->
    if e.keyCode == 13 # Return key pressed
      @doSubmitAction(this.refs.todo.value)

  doSubmitAction: (name) ->
    if name.length
      TodoActions.createTodo(this.refs.todo.value)
      @setState({ name: '', completed: false })

  newTodoClick: ->
    @doSubmitAction(this.refs.todo.value)

  render: ->
    div className: 'add-todo-group input-group input-group-lg',
      span className: 'input-group-addon',
        i className: 'glyphicon glyphicon-list-alt'
      input
        value: @state.name
        onChange: @onInputChange,
        onKeyDown: @onInputKeydown,
        ref: 'todo',
        placeholder: 'Enter New Todo Name'
        className: 'form-control'
      span className: 'input-group-btn',
        button
          className: 'btn btn-success'
          type: 'button'
          onClick: @newTodoClick,
            i className: 'glyphicon glyphicon-plus'

TodoListItem = React.createFactory React.createClass
  updateTodo: (e) ->
    if e.keyCode == 13 # Return key pressed
      todo = { id: @props.todo.id, name: @props.todo.name }
      TodoActions.updateTodo(todo)

  refreshTodo: (e)->
    todo = { id: @props.todo.id, name: e.target.value }
    TodoActions.refreshTodo(todo)

  toggleTodo: ->
    TodoActions.toggleTodo(@props.todo.id)

  deleteTodo: ->
    TodoActions.deleteTodo(@props.todo.id)

  render: ->
    inputClassName = 'form-control'
    if @props.todo.completed
      inputClassName += ' finished'

    div className: 'input-group input-group-lg',
      span className: 'input-group-addon',
        input
          type: 'checkbox'
          onChange: @toggleTodo
          checked: @props.todo.completed
      input
        type: 'text'
        value: @props.todo.name
        onKeyDown: @updateTodo
        onChange: @refreshTodo
        className: inputClassName
      span className: 'input-group-btn',
        button
          className: 'btn btn-danger'
          onClick: @deleteTodo
          type: 'button',
            i
              className: 'glyphicon glyphicon-remove'

TodoList = React.createFactory React.createClass
  render: ->
    div className: 'todos',
      _.map @props.todos, (todo) =>
        TodoListItem(todo: todo)

ClearCompleted = React.createFactory React.createClass
  clearCompleted: ->
    TodoActions.clearCompleted()

  render: ->
    div className: 'btn-clear-group',
      button
        className: 'btn btn-primary btn-clear'
        onClick: @clearCompleted
        'Clear Completed'

window.TodoIndex = React.createClass
  getInitialState: ->
    todos: []

  componentWillMount: ->
    TodoStore.listen(@onChange)
    TodoActions.initData(@props)

  onChange: (state) ->
    @setState(state)

  render: ->
    div className: 'outer-container',
      NewTodo()
      TodoList(todos: @state.todos)
      ClearCompleted()
