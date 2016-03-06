require 'spec_helper'

describe 'Creating todo lists' do

  def create_todo_list(options={})
    options[:title] ||= "Title"
    options[:description] ||= "Description"

    visit '/todo_lists'
    click_link 'New Todo list'

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it 'redirects to the homepage on success' do
    create_todo_list({:title => "Mi todo", :description => "aprender rails"})

    expect(page).to have_content("Mi todo")
  end

  it "displays an error when the title is skipped" do
    create_todo_list({:title => ''})

    expect(page).to have_content("Title can't be blank")
    expect(TodoList.count).to eq(0)
    expect(page).to_not have_content("Mi todo")
  end

  it "fails when the title length is less than 3 characters" do
    create_todo_list({:title => '123', :description => 'aprender rails'})

    expect(page).to have_content("Title is too short")
    expect(TodoList.count).to eq(0)
    expect(page).to_not have_content("Mi todo")
  end

  it "displays an error when the description is skipped" do
    create_todo_list({:description => ''})

    expect(page).to have_content("Description can't be blank")
    expect(TodoList.count).to eq(0)
    expect(page).to_not have_content("Mi todo")
  end

  it "fails when the description length is less than 4 characters" do
    create_todo_list({:description => '123'})

    expect(page).to have_content("Description is too short")
    expect(TodoList.count).to eq(0)
    expect(page).to_not have_content("Mi todo")
  end

end
