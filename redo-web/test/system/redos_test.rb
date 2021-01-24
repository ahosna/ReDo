require "application_system_test_case"

class RedosTest < ApplicationSystemTestCase
  setup do
    @redo = redos(:one)
  end

  test "visiting the index" do
    visit redos_url
    assert_selector "h1", text: "Redos"
  end

  test "creating a Redo" do
    visit redos_url
    click_on "New Redo"

    fill_in "Key", with: @redo.key
    fill_in "Type", with: @redo.type
    fill_in "Version", with: @redo.version
    click_on "Create Redo"

    assert_text "Redo was successfully created"
    click_on "Back"
  end

  test "updating a Redo" do
    visit redos_url
    click_on "Edit", match: :first

    fill_in "Key", with: @redo.key
    fill_in "Type", with: @redo.type
    fill_in "Version", with: @redo.version
    click_on "Update Redo"

    assert_text "Redo was successfully updated"
    click_on "Back"
  end

  test "destroying a Redo" do
    visit redos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Redo was successfully destroyed"
  end
end
