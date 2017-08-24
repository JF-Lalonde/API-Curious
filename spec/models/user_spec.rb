require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a user from omniauth information" do
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
    User.from_omniauth(OmniAuth.config.mock_auth[:reddit])
    new_user = User.first

    expect(new_user.uid).to eq("abc123")
    expect(new_user.username).to eq("Spartacus")
    expect(new_user.token).to eq("tokenstringything")
  end
end
