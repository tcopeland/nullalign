describe Nullalign::Reporter do

  context "validates_presence_of" do
    it "says everything's good" do
      expect {
        subject.report_validates_presence_problems([])
      }.to output(/Hooray!/).to_stdout
    end

    it "shows a missing constraint on a single model" do
      missing_constraints = [
        Nullalign::NonnullConstraint.new(
          WrongAccount,
          WrongAccount.table_name,
          "email"
        )
      ]

      expect {
        subject.report_validates_presence_problems(
          WrongAccount => missing_constraints
        )
      }.to output(/wrong_accounts:\s+email/).to_stdout
    end
  end

end
