class WrongAccount < ActiveRecord::Base
  validates :email, presence: true
end