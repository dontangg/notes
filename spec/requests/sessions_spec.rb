require 'spec_helper'

describe "Signing In" do
  it "redirects correctly after successfully signing in" do
    user = create(:user)

    visit sign_in_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "sign in"

    current_path.should eq(root_path)
  end

  it "shows errors when authentication fails" do
    user = create(:user)

    visit sign_in_path
    page.should_not have_selector('#flash-alert')
    fill_in "email", :with => user.email
    fill_in "password", :with => "bogus_password"
    click_button "sign in"

    current_path.should eq(sessions_path)
    page.should have_selector('#flash-alert')
  end
end
