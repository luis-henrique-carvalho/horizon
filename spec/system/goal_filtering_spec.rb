require 'rails_helper'

RSpec.describe "Goal Filtering and Sorting", type: :system do
  let(:user) { create(:user) }
  let!(:active_marketing) { create(:goal, user: user, title: "Active Marketing", category: :marketing, status: :on_track, deadline: 1.day.from_now) }
  let!(:active_product) { create(:goal, user: user, title: "Active Product", category: :product, status: :behind, deadline: 1.week.from_now) }
  let!(:completed_sales) { create(:goal, user: user, title: "Completed Sales", category: :sales, status: :completed, deadline: 1.month.from_now) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  describe "filtering by status" do
    it "shows active goals by default" do
      visit goals_path
      expect(page).to have_content("Active Marketing")
      expect(page).to have_content("Active Product")
      expect(page).not_to have_content("Completed Sales")
    end

    it "allows filtering by archived/completed goals" do
      visit goals_path
      click_on "Archived"
      expect(page).to have_content("Completed Sales")
      expect(page).not_to have_content("Active Marketing")
      expect(page).not_to have_content("Active Product")
    end
  end

  describe "filtering by category" do
    it "filters goals by category" do
      visit goals_path
      select "Marketing", from: "category"
      find("#apply-filters").click

      expect(page).to have_content("Active Marketing")
      expect(page).not_to have_content("Active Product")
    end
  end

  describe "sorting" do
    it "sorts by deadline" do
      visit goals_path
      select "Deadline: Soonest", from: "sort"
      find("#apply-filters").click

      # Soonest should be first
      expect(page.body.index("Active Marketing")).to be < page.body.index("Active Product")

      select "Deadline: Furthest", from: "sort"
      find("#apply-filters").click
      expect(page.body.index("Active Product")).to be < page.body.index("Active Marketing")
    end
  end
end
