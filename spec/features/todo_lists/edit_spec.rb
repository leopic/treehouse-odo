require 'spec_helper'

describe 'Editing todo lists' do
  # Runs in the setup phase, creates a :todo_list variable before each run
  let!(:todo_list) { todo_list = TodoList.create(title: 'Comida', description: 'Comida and such') }

  def update_todo_list(options={})
    options[:title] ||= "Title"
    options[:description] ||= "Description"
    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates a todo list properly" do
    update_todo_list :title => "New title", :description => "New description", :todo_list => todo_list

    expect(page).to have_content "Todo list was successfully updated."

    visit "/todo_lists"
    expect(page).to have_content "New title"

    todo_list.reload
    expect(todo_list.title).to eq "New title"
    expect(todo_list.description).to eq "New description"
  end

  it "fails to update with no title" do
    update_todo_list :title => '', :todo_list => todo_list
    expect(page).to have_content "Title can't be blank"
  end

  it "fails to update with short title" do
    update_todo_list :title => '123', :todo_list => todo_list
    expect(page).to have_content "Title is too short"
  end

  it "fails to update with no description" do
    update_todo_list :description => '', :todo_list => todo_list
    expect(page).to have_content "Description can't be blank"
  end

  it "fails to update with short title" do
    update_todo_list :description => '123', :todo_list => todo_list
    expect(page).to have_content "Description is too short"
  end

end
