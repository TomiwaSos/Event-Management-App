class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :event, touch: true
end
