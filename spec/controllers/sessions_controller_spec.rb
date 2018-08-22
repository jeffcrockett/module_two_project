require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  
  before do
    User.destroy_all
  end

let(:jeff) {User.create(username: 'Jeff', password: 'goodbye')}
  
  describe 'post create' do
    it 'logs you in with the correct password' do
      post :create, params: {username: jeff.username, password: jeff.password}
      expect(session[:user_id]).to eq(jeff.id)
    end

    it 'rejects invalid passwords' do
      post :create, params: {username: jeff.username, password: jeff.password + 'x'}
      expect(session[:user_id]).to be_nil
    end

    it 'rejects empty passwords' do
      post :create, params: {username: jeff.username, password: ''}
      expect(session[:user_id]).to be_nil
    end 
end
end
