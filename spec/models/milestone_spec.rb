require 'rails_helper'

RSpec.describe Milestone, type: :model do
  describe 'associations' do
    it { should belong_to(:goal) }
    it { should have_many(:subtasks).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:order) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:subtasks).allow_destroy(true) }
  end
end
