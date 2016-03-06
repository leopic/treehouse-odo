require 'spec_helper'

describe 'Destroying todo lists' do
  let!(:todo_list) { todo_list = TodoList.create(title: 'Comida', description: 'Comida and such') }

  it "is succesfull when destroying a todo list" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end

    expect(page).to have_content "Todo list was successfully destroyed."
    expect(TodoList.count).to eq 0
  end

end
