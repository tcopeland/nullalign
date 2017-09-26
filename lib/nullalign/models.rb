require 'active_record'

module Nullalign
  class Models
    MODEL_DIRECTORY_REGEXP = /models/

    attr_reader :load_path

    def initialize(load_path)
      @load_path = load_path
    end

    def dirs
      load_path.select { |lp| MODEL_DIRECTORY_REGEXP =~ lp.to_s }
    end

    def preload_all
      self.dirs.each do |d|
        Dir.glob(File.join(d, "**", "*.rb")).each do |model_filename|
          Kernel.require_dependency model_filename
        end
      end
    end

    def all
      ActiveRecord::Base.descendants.sort_by(&:name)
    end
  end
end
