require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { todo_list = TodoList.create(title: 'Comida', description: 'Comida and such') }

  # Before each test runs
  before do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Items"
    end
  end

  it "displays the title of the associated list" do
    expect(page).to have_content(todo_list.title)
  end

  it "displays no items when a todo list is empty" do
    expect(page.all("ul.todo_items li").size).to eq 0
  end

end