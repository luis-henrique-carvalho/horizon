class Milestone < ApplicationRecord
  belongs_to :goal
  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks, allow_destroy: true, reject_if: :all_blank

  validates :title, :order, presence: true

  def progress
    total_subtasks = subtasks.size
    return 0 if total_subtasks.zero?

    completed_subtasks = subtasks.select(&:completed?).size
    (completed_subtasks.to_f / total_subtasks * 100).round
  end
end
