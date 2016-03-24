require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  let(:user) { Fabricate(:user) }

  before do
    login
  end

  describe 'GET #users' do
    it 'returns 200 status' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(200)
    end

    it 'should include email if current user' do
      get :show, params: { id: subject.current_user.id }
      expect(response.body).to include(subject.current_user.email)
    end

    it 'should not include email for other users' do
      user2 = Fabricate(:user)
      get :show, params: { id: user2.id }
      expect(response.body).not_to include(user2.email)
    end
  end
end
