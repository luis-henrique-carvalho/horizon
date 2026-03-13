require 'rails_helper'

RSpec.describe "Goals", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:goal) { create(:goal, user: user, title: 'My User Goal') }
  let!(:other_goal) { create(:goal, user: other_user, title: 'Other User Goal') }

  before do
    sign_in user
  end

  describe "GET /goals" do
    it "returns http success and scopes to current user" do
      get goals_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('My User Goal')
      expect(response.body).not_to include('Other User Goal')
    end
  end

  describe "GET /goals/:id" do
    it "returns http success for own goal" do
      get goal_path(goal)
      expect(response).to have_http_status(:success)
    end

    it "redirects or errors for other user goal" do
      get goal_path(other_goal)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /goals/new" do
    it "returns http success" do
      get new_goal_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /goals" do
    let(:valid_attributes) do
      { title: 'New awesome goal', category: 'marketing', status: 'on_track', deadline: 1.month.from_now }
    end

    let(:invalid_attributes) do
      { title: '' }
    end

    it "creates a new goal for the user and redirects" do
      expect {
        post goals_path, params: { goal: valid_attributes }
      }.to change(user.goals, :count).by(1)
      expect(response).to redirect_to(goals_path)
    end

    it "does not create with invalid attributes" do
      expect {
        post goals_path, params: { goal: invalid_attributes }
      }.to change(Goal, :count).by(0)
    end
  end

  describe "GET /goals/:id/edit" do
    it "returns http success for own goal" do
      get edit_goal_path(goal)
      expect(response).to have_http_status(:success)
    end

    it "returns 404 for other user goal" do
      get edit_goal_path(other_goal)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PATCH /goals/:id" do
    it "updates own goal and redirects" do
      patch goal_path(goal), params: { goal: { title: 'Updated Title' } }
      goal.reload
      expect(goal.title).to eq('Updated Title')
      expect(response).to redirect_to(goals_path)
    end
  end

  describe "DELETE /goals/:id" do
    it "destroys own goal and redirects" do
      expect {
        delete goal_path(goal)
      }.to change(Goal, :count).by(-1)
      expect(response).to redirect_to(goals_path)
    end

    it "returns 404 for other user goal" do
      delete goal_path(other_goal)
      expect(response).to have_http_status(:not_found)
    end
  end
end
