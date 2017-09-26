class CorrectAccount < ActiveRecord::Base
  validates :email, presence: true
end