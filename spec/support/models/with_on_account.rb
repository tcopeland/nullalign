class WithOnAccount < ActiveRecord::Base

  validates :email, presence: true, on: -> { rand > 0.5 }

end
