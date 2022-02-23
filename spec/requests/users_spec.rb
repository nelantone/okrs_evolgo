require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user)   { create(:user, id: 42) }
  let(:user_id) { user.id }

  # As a user I want to create a Goal.
  describe 'POST /users/:user_id/create_goal' do
    let(:valid_user_attributes) do
      { user_id: 42,
        title: 'Secret of life owner' }
    end

    context 'when user can create a valid Goal' do
      before { post "/users/#{user_id}/create_goal", params: valid_user_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context "when user can't create an invalid Goal" do
      before { post "/users/#{user_id}/create_goal", params: { user_id: 42 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # A a user I want to create “Key Results”,
  # associated with a goal, to track the progress of my goal
  describe 'POST /users/:user_id/goals/goal_id/create_goal_key_result' do
    let(:goal)    { create(:goal, id: 21) }
    let(:goal_id) { goal.id }
    let(:valid_goal_attributes) do
      { goal_id: 21,
        user_id: 42,
        status: 0.0,
        title: 'Test my RESTful app',
        start_date: Time.zone.local(2022, 2, 2, 2, 22),
        end_date: Time.zone.local(2022, 2, 2, 2, 22) + 1.day }
    end

    context 'when user can create a valid Key-result' do
      before { post "/users/#{user_id}/goals/#{goal_id}/create_goal_key_result", params: valid_goal_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context "when user can't create an invalid Key-result" do
      before do
        post "/users/#{user_id}/goals/#{goal_id}/create_goal_key_result", params: { user_id: 42, goal_id: 21 }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end
end
