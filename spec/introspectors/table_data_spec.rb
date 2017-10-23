require 'spec_helper'

describe Nullalign::Introspectors::TableData do
  
  describe "finding nonnull constraints" do
    it "finds none when the table does not exist" do
      expect(subject.nonnull_constraints(Nonexistent)).to be_empty
    end

    it "gets one" do
      expect(
        Nullalign::Introspectors::TableData.new.nonnull_constraints_by_table(
          CorrectAccount,
          CorrectAccount.table_name
        )[1].column
      ).to eq "email"
    end
  end
end
