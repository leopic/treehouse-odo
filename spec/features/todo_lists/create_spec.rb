require 'spec_helper'

describe 'Creating todo lists' do
  it 'redirects to the homepage on success' do
    visit 'todo_lists/'
    click_link 'New Todo list'
    expect(page).to have_content('New Todo List')

    fill_in "Title", with: "Mi todo"
    fill_in "Description", with: "aprender rails"
    click_button "Create Todo list"

    expect(page).to have_content("Mi todo")
  end

  it "displays an error when the title is skipped" do
    visit "todo_lists/"
    click_link 'New Todo list'

    fill_in "Title", with: nil
    fill_in "Description", with: "aprender rails"
    click_button "Create Todo list"

    expect(page).to have_content("Title can't be blank")
    expect(TodoList.count).to eq(0)

    expect(page).to_not have_content("Mi todo")
  end

  it "fails when the title length is less than 3 characters" do
    visit "todo_lists/"
    click_link 'New Todo list'

    fill_in "Title", with: "123"
    fill_in "Description", with: "aprender rails"
    click_button "Create Todo list"

    expect(page).to have_content("Title is too short")
    expect(TodoList.count).to eq(0)

    expect(page).to_not have_content("Mi todo")
  end

  it "displays an error when the description is skipped" do
    visit "todo_lists/"
    click_link 'New Todo list'

    fill_in "Title", with: "1234"
    fill_in "Description", with: nil
    click_button "Create Todo list"

    expect(page).to have_content("Description can't be blank")
    expect(TodoList.count).to eq(0)

    expect(page).to_not have_content("Mi todo")
  end

  it "fails when the description length is less than 3 characters" do
    visit "todo_lists/"
    click_link 'New Todo list'

    fill_in "Title", with: "valid title"
    fill_in "Description", with: "123"
    click_button "Create Todo list"

    expect(page).to have_content("Description is too short")
    expect(TodoList.count).to eq(0)

    expect(page).to_not have_content("Mi todo")
  end

end
