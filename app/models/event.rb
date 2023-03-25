class Event < ApplicationRecord
  has_many :comments
  belongs_to :user, foreign_key: 'created_by'

  after_save :check_if_active

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
end
