describe Nullalign::NonnullConstraint do

  let(:nonnull_constraint) do
    Nullalign::NonnullConstraint.new(
      CorrectAccount,
      CorrectAccount.table_name,
      "city"
    )
  end

  describe "value objectiness" do
    it "holds onto model, table name, and columns" do
      expect(nonnull_constraint.model).to eq(CorrectAccount)
      expect(nonnull_constraint.table_name).to eq("correct_accounts")
      expect(nonnull_constraint.column).to eq(
        "city"
      )
    end
  end

  describe "equality test" do
    it "passes when everything matches" do
      expect(nonnull_constraint).to eq(
        Nullalign::NonnullConstraint.new(
          "CorrectAccount".constantize,
          "correct_accounts",
          "city"
        )
      )
    end

    it "fails when tables are different" do
      expect(nonnull_constraint).not_to eq(
        Nullalign::NonnullConstraint.new(
          NewCorrectAccount,
          NewCorrectAccount.table_name,
          "city"
        )
      )
    end

    it "fails when columns are different" do
      expect(nonnull_constraint).not_to eq(
        Nullalign::NonnullConstraint.new(
          CorrectAccount,
          NewCorrectAccount.table_name,
          "city"
        )
      )
    end
  end

end
