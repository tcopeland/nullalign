class WithUnlessAccount < ActiveRecord::Base

  validates :email, presence: true, unless: -> { rand > 0.5 }

end
