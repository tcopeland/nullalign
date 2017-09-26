module Nullalign
  module Reporters
    class Base
      TERMINAL_WIDTH = 80

      RED = 31
      GREEN = 32

      def use_color(code)
        print "\e[#{code}m"
      end

      def use_default_color
        use_color(0)
      end

      def report_success(macro)
        use_color(GREEN)
        # TODO not using 'macro' but leaving it here in case this gets
        # rolled into consistency_fail
        puts "Hooray! All presence validators are backed by a non-null constraint."
        use_default_color
      end

      def divider(pad_to = TERMINAL_WIDTH)
        puts "-" * [pad_to, TERMINAL_WIDTH].max
      end

      def report_failure_header(macro, longest_model_length)
        puts
        use_color(RED)
        # TODO not using 'macro' but leaving it here in case this gets
        # rolled into consistency_fail
        puts "There are presence validators that aren't backed by non-null constraints."
        use_default_color
        divider(longest_model_length * 2)

        column_1_header, column_2_header = column_headers
        print column_1_header.ljust(longest_model_length + 2)
        puts column_2_header

        divider(longest_model_length * 2)
      end

      def column_1(model)
        model.name
      end

      def column_headers
        ["Model", "Table Columns"]
      end

      def report(null_constraints_by_model)
        if null_constraints_by_model.empty?
          report_success(macro)
        else
          null_constraints_by_table_name = null_constraints_by_model.map do |model, columns|
            [column_1(model), model, columns]
          end.sort_by(&:first)
          longest_model_length = null_constraints_by_table_name.map(&:first).
                                                       sort_by(&:length).
                                                       last.
                                                       length
          column_1_header_length = column_headers.first.length
          longest_model_length = [longest_model_length, column_1_header_length].max

          report_failure_header(macro, longest_model_length)

          null_constraints_by_table_name.each do |table_name, model, columns|
            columns.each do |column|
              print model.name.ljust(longest_model_length + 2)
              puts column.table_name + ": " + columns.map {|x| x.column }.join(', ')
            end
          end
          divider(longest_model_length * 2)
        end
        puts
      end
    end
  end
end
