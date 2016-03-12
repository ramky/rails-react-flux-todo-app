class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render partial: 'todos/todo', locals: {todo: @todo}
    else
      render json: @todo.errors.to_json
    end
  end

  def update_name
    @todo = Todo.find(params[:id])
    if @todo.update(name: params[:name])
      render partial: 'todos/todo', locals: {todo: @todo}
    else
      render json: @todo.errors.to_json
    end
  end

  def update_completed
    @todo = Todo.find(params[:id])
    if @todo.update(completed: !@todo.completed)
      render partial: 'todos/todo', locals: {todo: @todo}
    else
      render json: @todo.errors.to_json
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    if @todo.destroy
      render json: { status: :ok }.to_json
    else
      render json: @todo.errors.to_json
    end
  end

  def clear_completed
    begin
      Todo.completed.delete_all
      render json: { status: :ok }.to_json
    rescue => e
      render json: e.to_json
    end
  end

  private

  def todo_params
    params.require(:todo).permit!
  end
end
