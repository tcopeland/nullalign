class WithIfAccount < ActiveRecord::Base

  validates :email, presence: true, if: -> { rand > 0.5 }

end
