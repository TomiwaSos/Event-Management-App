class Status < ApplicationRecord
  has_many :events

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_destroy :check_usage, prepend: true

  def check_usage
    return unless events.present?

    errors.add(:events, 'are assigned to this status')
    throw :abort
  end
end
