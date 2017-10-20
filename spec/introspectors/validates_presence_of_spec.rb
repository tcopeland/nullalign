require 'spec_helper'

describe Nullalign::Introspectors::ValidatesPresenceOf do

  describe "finding missing nonnull constraints" do
    it "finds one" do
      indexes = subject.missing_nonnull_constraints(WrongAccount)

      expect(indexes).to eq([
        Nullalign::NonnullConstraint.new(
          WrongAccount,
          WrongAccount.table_name,
          "email"
        )
      ])
    end

    it "finds none when they're already in place" do
      expect(subject.missing_nonnull_constraints(CorrectAccount)).to be_empty
    end

  end

end
