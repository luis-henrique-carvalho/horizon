class Milestone < ApplicationRecord
  belongs_to :goal
  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks, allow_destroy: true, reject_if: :all_blank

  validates :title, :order, presence: true
  validate :must_have_at_least_one_subtask

  def progress
    total_subtasks = subtasks.size
    return 0 if total_subtasks.zero?

    completed_subtasks = subtasks.select(&:completed?).size
    (completed_subtasks.to_f / total_subtasks * 100).round
  end

  private

  def must_have_at_least_one_subtask
    if subtasks.empty? || subtasks.all?(&:marked_for_destruction?)
      errors.add(:base, "Each milestone must have at least one subtask")
    end
  end
end
