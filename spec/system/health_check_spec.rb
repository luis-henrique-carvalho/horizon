require "rails_helper"

RSpec.describe "HealthCheck", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "is healthy" do
    visit "/up"
    expect(page.status_code).to eq(200)
  end
end
