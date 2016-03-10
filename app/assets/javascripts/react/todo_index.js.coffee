{ div, h1, ul, li, a, span, label, input, br } = React.DOM

TodoForm = React.createFactory React.createClass
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
    todoItemClasses = 'list-item'
    btnText         = 'Check'
    if @props.todo.checked
      todoItemClasses += ' checked'
      btnText = 'Uncheck'
    li className: todoItemClasses,
      a className: 'btn btn-primary', onClick: @onToggleTodo, btnText
      span className: 'list-text', @props.todo.name

TodoList = React.createFactory React.createClass
  render: ->
    ul className: 'list-unstyled',
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
    div className: 'container',
      div className: 'row',
        div className: 'col-xs-12',
          TodoForm()
          br {}
          TodoList(todos: @state.todos)
