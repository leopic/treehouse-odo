class TodoItemsController < ApplicationController
  def index
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def new
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_item.new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_item.new(todo_list_item_params)
    if @todo_item.save
      flash[:success] = "Success"
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "Error"
      render action: :new
    end
  end

  private
  def todo_list_item_params
    params[:todo_item].permit(:content)
  end

end
