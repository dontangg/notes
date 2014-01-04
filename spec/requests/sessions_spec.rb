require 'spec_helper'

describe "Logging In" do
  it "redirects correctly after successfully logging in" do
    user = create(:user)

    visit log_in_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log In"

    current_path.should eq(root_path)
  end

  it "shows errors when authentication fails" do
    user = create(:user)

    visit log_in_path
    page.should_not have_selector('#flashalert')
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "bogus_password"
    click_button "Log In"

    current_path.should eq(sessions_path)
    page.should have_selector('#flashalert')
  end
end
