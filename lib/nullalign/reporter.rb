require 'nullalign/reporters/validates_presence_of'

module Nullalign
  class Reporter
    def report_validates_presence_problems(null_constraints_by_model)
      Nullalign::Reporters::ValidatesPresenceOf.new.report(null_constraints_by_model)
    end
  end
end
