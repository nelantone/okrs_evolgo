class UsersController < ApplicationController
  before_action :set_user

  # As a user I want to create a Goal.
  def create_goal
    @user.goals.create!(goal_params)
    json_response(@user, :created)
  end

  # A a user I want to create “Key Results”,
  # associated with a goal, to track the progress of my goal
  def create_goal_key_result
    @goal = Goal.find(params[:goal_id])
    @goal.key_results.create!(key_results_params)
    json_response(@user, :created)
  end

  # A a user I want to get the list of all goals that are owned by me
  def goals
    update_progress
    json_response(@user.goals)
  end

  private

  def goal_params
    params.permit(:user_id, :title, :start_date, :end_date, :progress)
  end

  def key_results_params
    params.permit(:user_id, :goal_id, :title, :status)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def update_progress
    @user.goals.each { |goal| goal.update(progress: :progress ) }
  end
end
