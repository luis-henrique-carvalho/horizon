class Goal < ApplicationRecord
  belongs_to :user
  has_many :milestones, dependent: :destroy
  accepts_nested_attributes_for :milestones, allow_destroy: true, reject_if: :all_blank

  enum :category, { marketing: 0, product: 1, sales: 2, security: 3, other: 4 }
  enum :status, { on_track: 0, behind: 1, completed: 2, at_risk: 3 }

  validates :title, :category, :status, presence: true

  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :active, -> { where.not(status: :completed) }
  scope :archived, -> { where(status: :completed) }

  def self.order_by_deadline(direction = :asc)
    order(Arel.sql("deadline #{direction.to_s.upcase} NULLS LAST"))
  end

  def self.order_by_progress(direction = :desc)
    # Using Ruby sort since progress is virtual (overrides column)
    all.sort_by(&:progress).send(direction == :desc ? :reverse : :itself)
  end

  def progress
    total_milestones = milestones.size
    return 0 if total_milestones.zero?

    (milestones.sum(&:progress).to_f / total_milestones).round
  end

  before_save :update_status_if_completed

  private

  def update_status_if_completed
    self.status = :completed if progress == 100
  end
end
