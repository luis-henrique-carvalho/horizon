require 'rails_helper'

RSpec.describe "Subtasks", type: :request do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user: user) }
  let(:milestone) { create(:milestone, goal: goal) }
  let(:subtask) { create(:subtask, milestone: milestone, completed: false) }

  before do
    sign_in user
  end

  describe "PATCH /subtasks/:id" do
    context "with turbo_stream format" do
      it "updates the subtask and renders a turbo_stream response" do
        patch subtask_path(subtask), params: { subtask: { completed: true } }, as: :turbo_stream

        expect(response).to have_http_status(:success)
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")

        # Check that it includes the expected turbo-stream actions
        expect(response.body).to include('turbo-stream action="replace" target="milestone_')
        expect(response.body).to include('turbo-stream action="replace" target="goal_')
        expect(response.body).to include('turbo-stream action="update" target="goal_')
      end

      it "does not raise NoMethodError for set_attribute, add_class, remove_class" do
        expect {
          patch subtask_path(subtask), params: { subtask: { completed: true } }, as: :turbo_stream
        }.not_to raise_error
      end
    end
  end
end
