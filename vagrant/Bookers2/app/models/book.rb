class Book < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :body, length: { in: 0..200 }, presence: true

end
