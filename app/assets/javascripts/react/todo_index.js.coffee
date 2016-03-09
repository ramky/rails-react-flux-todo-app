{ div, h1, ul, li, a, span } = React.DOM

window.TodoIndex = React.createClass
  render: ->
    div className: 'container',
      div className: 'row',
        div className: 'col-xs-12',
          h1 {}, 'Todo List'
            ul className: 'list-unstyled',
              _.map @props.todos, (todo) =>
                li className: 'list-item',
                  a className: 'btn btn-primary', 'Check'
                  span className: 'list-text', todo.name
