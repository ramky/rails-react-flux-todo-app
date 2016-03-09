{ div, h1, ul, li } = React.DOM

window.TodoIndex = React.createClass
  render: ->
    div {},
      h1 {}, 'Todo List'
        ul
        _.map @props.todos, (todo) =>
          li {}, todo.name
