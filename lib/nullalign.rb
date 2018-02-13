require 'nullalign/models'
require 'nullalign/introspectors/table_data'
require 'nullalign/introspectors/validates_presence_of'
require 'nullalign/reporter'
require 'nullalign/railtie'

module Nullalign
  def self.run
    models = Nullalign::Models.new($LOAD_PATH)
    models.preload_all

    reporter = Nullalign::Reporter.new

    introspector = Nullalign::Introspectors::ValidatesPresenceOf.new
    problems = problems(models.all, introspector)
    reporter.report_validates_presence_problems(problems)
    problems.empty?
  end

  def self.generate_migration
    models = Nullalign::Models.new($LOAD_PATH)
    models.preload_all

    reporter = Nullalign::Reporter.new

    introspector = Nullalign::Introspectors::ValidatesPresenceOf.new
    problems = problems(models.all, introspector)
    if problems.empty?
      puts "Hooray! All presence validators are backed by a non-null constraint."
    else
      str = "class AddMissingNonnullConstraints < ActiveRecord::Migration[5.1]\n"
      str << "  def change\n"
      null_constraints_by_table_name = problems.map do |model, columns|
        [model.name, model, columns]
      end.sort_by(&:first)
      counter = 0
      null_constraints_by_table_name.each do |table_name, model, columns|
        columns.each do |constraint|
          counter += 1
          str << "    change_column_null :#{model.table_name}, :#{constraint.column}, false\n"
        end
      end
      str << "  end\n"
      str << "end\n"
      filename = "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_add_missing_nonnull_constraints.rb"
      puts "Adding migration #{File.basename(filename)} containing #{counter} change_column_null entries"
      File.open(filename, "w") {|f| f.syswrite(str)}
    end
  end

  private

  def self.problems(models, introspector)
    models.map do |m|
      [m, introspector.missing_nonnull_constraints(m)]
    end.reject do |m, columns|
      columns.empty?
    end
  end
end
