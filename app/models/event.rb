class Event < ApplicationRecord
  has_many :comments
  belongs_to :user, foreign_key: 'created_by'
end
