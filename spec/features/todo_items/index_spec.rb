require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { todo_list = TodoList.create(title: 'Comida', description: 'Comida and such') }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "Items"
    end
  end

  it "displays the title of the associated list" do
    visit_todo_list todo_list
    expect(page).to have_content(todo_list.title)
  end

  it "displays no items when a todo list is empty" do
    visit_todo_list todo_list
    expect(page.all("ul.todo_items_list li").size).to eq 0
  end

  it "displays items when a todo list has content" do
    todo_list.todo_item.create(content: 'Cafe')
    todo_list.todo_item.create(content: 'Arroz')
    # todo_list.save
    visit_todo_list todo_list
    expect(page.all("ul.todo_items_list li").size).to eq 2
    within ".todo_items_list" do
      expect(page).to have_content "Cafe"
      expect(page).to have_content "Arroz"
    end
  end

end