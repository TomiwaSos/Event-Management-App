class Event < ApplicationRecord
  has_many :comments
  belongs_to :user, foreign_key: 'created_by'
  has_one :status, foreign_key: 'status_id'

  validates :title, presence: true, uniqueness: true
  validate :event_is_active_or_will_be

  after_save :check_if_active

  def event_is_active_or_will_be
    errors.add(:active_to, "date can't be in the past") if active_to.to_date < Date.today
  end

  def check_if_active
    today = Date.today
    if (active_from.to_date..active_to.to_date) === today
      update_column(:active, true)
    else
      update_column(:active, false)
    end
  end

  def author
    User.find(created_by).username
  end

  def status
    Status.find(status_id).name
  end

  def self.search(search)
    if search.present?
      results = []
      search.keys.each do |key|
        results << where("#{key} LIKE ?", "%#{search[key]}%").uniq if search[key].present?
      end
      results = results.flat_map(&:itself).uniq

    else
      results = where("")
    end

    results
  end
end
