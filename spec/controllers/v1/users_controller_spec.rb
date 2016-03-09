require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  let(:user) { Fabricate(:user) }

  before do
    sign_in(user)
  end

  describe 'GET #users' do
    it 'returns http success' do
      auth_get :show, id: user.id
      expect(response).to have_http_status(200)
    end
  end
end
