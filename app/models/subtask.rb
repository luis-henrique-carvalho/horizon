class Subtask < ApplicationRecord
  belongs_to :milestone
  validates :title, presence: true

  before_save :update_completed_at, if: :completed_changed?

  private

  def update_completed_at
    if completed?
      self.completed_at = Time.current
    else
      self.completed_at = nil
    end
  end
end
