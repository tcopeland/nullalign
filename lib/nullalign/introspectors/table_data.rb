require 'nullalign/nonnull_constraint'

module Nullalign
  module Introspectors
    class TableData
      def nonnull_constraints(model)
        return [] if !model.table_exists?

        nonnull_constraints_by_table(model, model.table_name)
      end

      def nonnull_constraints_by_table(model, table_name)
        model.columns.select {|c| !c.null }.map {|c| Nullalign::NonnullConstraint.new(model, table_name, c.name) }
      end
    end
  end
end
