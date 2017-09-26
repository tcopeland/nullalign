require 'nullalign/models'
require 'nullalign/introspectors/table_data'
require 'nullalign/introspectors/validates_presence_of'
require 'nullalign/reporter'

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
  
  private
  
  def self.problems(models, introspector)
    models.map do |m|
      [m, introspector.missing_nonnull_constraints(m)]
    end.reject do |m, columns|
      columns.empty?
    end
  end
end