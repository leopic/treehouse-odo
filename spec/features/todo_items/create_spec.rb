require 'spec_helper'

describe "The item added will be successfully displayed" do
  let!(:todo_list) { todo_list = TodoList.create(title: 'Comida', description: 'Comida and such') }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "Items"
    end
  end

  it "is displayed okay" do
    visit_todo_list todo_list
    click_link "Add"
    fill_in "Content", with: "Leche"
    click_button "Save"
    expect(page).to have_content("Success")

    within ".todo_items_list" do
      expect(page).to have_content("Leche")
    end
  end

end