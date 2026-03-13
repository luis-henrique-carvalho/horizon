class Milestone < ApplicationRecord
  belongs_to :goal
  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks, allow_destroy: true, reject_if: :all_blank

  validates :title, :order, presence: true

  def progress
    return 0 if subtasks.empty?

    (subtasks.where(completed: true).count.to_f / subtasks.count * 100).round
  end
end
