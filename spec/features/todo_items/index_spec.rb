require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { todo_list = TodoList.create(title: 'Comida', description: 'Comida and such') }

  it "displays no items when a todo list is empty" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Items"
    end
  end
end