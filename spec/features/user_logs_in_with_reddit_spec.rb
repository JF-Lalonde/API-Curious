require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using reddit oauth2" do
    stub_omniauth
    visit root_path
    assert_equal 200, page.status_code
    click_link "Sign in with Reddit"
    assert_equal "/", current_path
    expect(page).to have_content("Spartacus")
    expect(page).to have_link("Logout")
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:reddit] = OmniAuth::AuthHash.new({
    provider: "reddit",
    uid: "abc123",
    info: {
      name: "Spartacus"
    },
    credentials: {
      token: "tokenstringything"
    }
  })
end

