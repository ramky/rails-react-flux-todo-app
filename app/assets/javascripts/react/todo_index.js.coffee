{ div, h1, ul, li, a, span, label, input } = React.DOM

TodoForm = React.createFactory React.createClass
  render: ->
    div className: 'form-group',
    label {}, 'Enter Todo'
    input className: 'form-content', placeholder: 'Enter Todo Name'

TodoListItem = React.createFactory React.createClass
  render: ->
    li className: 'list-item',
      a className: 'btn btn-primary', 'Check'
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
    @setState(todos: @props.todos)

  render: ->
    div className: 'container',
      div className: 'row',
        div className: 'col-xs-12',
          h1 {}, 'Todo List'
          TodoForm()
          TodoList(todos: @state.todos)
