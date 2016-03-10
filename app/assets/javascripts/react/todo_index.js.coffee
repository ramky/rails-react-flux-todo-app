{ div, h1, ul, li, a, span, label, input, button, i } = React.DOM

NewTodo = React.createFactory React.createClass
  getInitialState: ->
    return { name: '', checked: false }

  onInputChange: (e) ->
    @setState({ name: e.target.value, checked: false })

  onInputKeydown: (e) ->
    if e.keyCode == 13 && this.refs.todo.value.length
      TodoActions.submitTodo(this.refs.todo.value)
      @setState(todoName: '')

  render: ->
    div className: 'form-group',
    label {}, 'Enter Todo'
    input
      onChange: @onInputChange,
      onKeyDown: @onInputKeydown,
      ref: 'todo',
      className: 'form-control',
      placeholder: 'Enter Todo Name'
      value: @state.todoName

TodoListItem = React.createFactory React.createClass
  onToggleTodo: ->
    TodoActions.toggleTodo(@props.todo.id)

  render: ->
    inputClassName = 'form-control'
    if @props.todo.checked
      inputClassName += ' finished'

    div className: 'input-group input-group-lg',
      span className: 'input-group-addon',
        input
          type: 'checkbox'
          onChange: @onToggleTodo
          checked: @props.todo.checked
      input
        type: 'text'
        value: @props.todo.name
        className: inputClassName
      span className: 'input-group-btn',
        button
          className: 'btn btn-danger'
          type: 'button',
            i
              className: 'glyphicon glyphicon-remove'

TodoList = React.createFactory React.createClass
  render: ->
    div className: 'todos',
      _.map @props.todos, (todo) =>
        TodoListItem(todo: todo)

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
