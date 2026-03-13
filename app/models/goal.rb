class Goal < ApplicationRecord
  belongs_to :user

  enum :category, { marketing: 0, product: 1, sales: 2, security: 3, other: 4 }
  enum :status, { on_track: 0, behind: 1, completed: 2, at_risk: 3 }

  validates :title, :category, :status, presence: true
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  
  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.progress ||= 0
  end
end
