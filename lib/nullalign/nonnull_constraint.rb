module Nullalign
  class NonnullConstraint
    attr_reader :model, :table_name, :column
    def initialize(model, table_name, column)
      @model = model
      @table_name = table_name
      @column = column.to_s
    end

    def ==(other)
      self.table_name == other.table_name &&
        self.column == other.column
    end
  end
end
