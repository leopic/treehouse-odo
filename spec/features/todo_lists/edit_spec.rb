require 'spec_helper'

describe 'Editing todo lists' do

  it "updates a todo list properly" do
    todo_list = TodoList.create(title: 'Comida', description: 'Comida and such')

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end
    expect(page).to have_content "Editing Todo List"

    fill_in "Title", with: "New title"
    fill_in "Description", with: "New description"
    click_button "Update Todo list"
    expect(page).to have_content "Todo list was successfully updated."

    visit "/todo_lists"
    expect(page).to have_content "New title"

    todo_list.reload
    expect(todo_list.title).to eq "New title"
    expect(todo_list.description).to eq "New description"
  end

end
