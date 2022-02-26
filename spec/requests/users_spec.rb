require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user)   { create(:user, id: 42) }
  let(:user_id) { user.id }

  # To create a user.
  describe 'POST users' do
    let(:just_user_attributes) { { owner: 'just an user' } }

    context 'when user can create a valid Goal' do
      before { post '/users', params: just_user_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end
  end

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
  describe 'POST /users/:user_id/goals/:goal_id/create_goal_key_result' do
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

    context "when user can't create an invalid Key-result with wrong status number" do
      let(:invalid_goal_attributes) do
        { goal_id: 21,
          user_id: 42,
          status: 4.0,
          title: 'Test my RESTful app',
          start_date: Time.zone.local(2022, 2, 2, 2, 22),
          end_date: Time.zone.local(2022, 2, 2, 2, 22) + 1.day }
      end

      before do
        post "/users/#{user_id}/goals/#{goal_id}/create_goal_key_result", params: invalid_goal_attributes
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Status 4.0 is not a valid number/)
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

  # A a user I want to get the list of all goals that are owned by me
  describe 'GET /users/:user_id/goals' do
    before do
      create(:goal, title: 'new goal 1', user: user)
      create(:goal, title: 'new goal 2', user: user)
      create(:goal, title: 'new goal 3', user: user)

      create(:key_result, goal: goal_done, user: new_user, status: 1.0, title: 'first goal done')
      create(:key_result, goal: goal_done, user: new_user, status: 1.0, title: 'second goal done')

      create(:key_result, goal: goal_done2, user: new_user2, status: 0.5, title: 'goal not done')
      create(:key_result, goal: goal_done2, user: new_user2, status: 1.0, title: 'goal done')

      create(:key_result, goal: goal_done3, user: new_user3, status: 0.5, title: 'goal not done')
      create(:key_result, goal: goal_done3, user: new_user3, status: 0.0, title: 'goal not started')
    end

    let(:valid_user_attributes) do
      { user_id: 42,
        title: 'Secret of life owner' }
    end

    let(:new_user) { create(:user, owner: 'super user', id: 45) }
    let(:new_user_id) { new_user.id }
    let(:goal_done) { create(:goal, user: new_user, id: 7) }
    let(:new_valid_user_attributes) { { user_id: new_user_id, title: 'super user' } }

    let(:new_user2) { create(:user, owner: 'super user', id: 46) }
    let(:new_user2_id) { new_user2.id }
    let(:goal_done2) { create(:goal, user: new_user2, id: 8) }
    let(:new_valid_user_attributes2) { { user_id: new_user2_id, title: 'super user' } }

    let(:new_user3) { create(:user, owner: 'super user', id: 47) }
    let(:new_user3_id) { new_user3.id }
    let(:goal_done3) { create(:goal, user: new_user3, id: 9) }
    let(:new_valid_user_attributes3) { { user_id: new_user3_id, title: 'super user' } }

    context 'when the user get the list of all own goals' do
      before do
        get "/users/#{user_id}/goals", params: valid_user_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the 3 goals' do
        response_to_hash = JSON.parse(response.body)
        expect(response_to_hash.size).to eq(3)
      end
    end

    context 'when the user want to see the progress of the goals and is 100%' do
      before do
        get "/users/#{new_user_id}/goals", params: new_valid_user_attributes
      end

      it 'returns only one goal with 100% progress' do
        response_to_hash = JSON.parse(response.body)
        expect(response_to_hash.first['progress']).to eq('100%')
      end
    end

    context 'when the user want to see the progress of the goals and is 50%' do
      before do
        get "/users/#{new_user2_id}/goals", params: new_valid_user_attributes2
      end

      it 'returns only one goal with 50% progress' do
        response_to_hash = JSON.parse(response.body)
        expect(response_to_hash.first['progress']).to eq('50%')
      end
    end

    context 'when the user want to see the progress of the goals and is 0%' do
      before do
        get "/users/#{new_user3_id}/goals", params: new_valid_user_attributes3
      end

      it 'returns only one goal with 0% progress' do
        response_to_hash = JSON.parse(response.body)
        expect(response_to_hash.first['progress']).to eq('0%')
      end
    end
  end
end
