class Goal < ApplicationRecord
  belongs_to :user
  has_many :milestones, dependent: :destroy
  accepts_nested_attributes_for :milestones, allow_destroy: true, reject_if: :all_blank

  enum :category, { marketing: 0, product: 1, sales: 2, security: 3, other: 4 }
  enum :status, { on_track: 0, behind: 1, completed: 2, at_risk: 3 }

  validates :title, :category, :status, presence: true

  def progress
    return 0 if milestones.empty?

    (milestones.sum(&:progress).to_f / milestones.count).round
  end

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    # No dynamic defaults for now
  end
end
