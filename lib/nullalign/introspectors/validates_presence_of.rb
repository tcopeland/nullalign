require 'nullalign/nonnull_constraint'

module Nullalign
  module Introspectors
    class ValidatesPresenceOf
      def instances(model)
        model.validators.select do |v|
          v.class == ActiveRecord::Validations::PresenceValidator && (v.options.keys & %i(on if unless)).empty?
        end
      end

      def desired_nonnull_constraints(model)
        instances(model).map do |v|
          v.attributes.map do |attribute|
            # This next bit is to avoid a false positive in the case where a validator uses
            # an association name rather than the field name (i.e. user vs user_id).
            association = model.reflect_on_all_associations.detect {|r| r.name == attribute }
            attribute_value = if association != nil
              association.foreign_key
            else
              attribute
            end
            Nullalign::NonnullConstraint.new(model,
                                       model.table_name,
                                       attribute_value)
          end
        end.flatten
      end
      private :desired_nonnull_constraints

      def missing_nonnull_constraints(model)
        return [] unless model.connection.tables.include? model.table_name
        existing_nonnull_constraints = TableData.new.nonnull_constraints(model)

        desired_nonnull_constraints(model).reject do |index|
          existing_nonnull_constraints.include?(index)
        end
      end
    end
  end
end
