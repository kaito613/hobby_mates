class Comment < ApplicationRecord
  belongs_to :board
  belongs_to :user

  validates :message, presence: true
end
