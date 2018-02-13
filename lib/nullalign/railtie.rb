if defined?(Rails)
  module Nullalign
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'tasks/nullalign.rake'
      end
    end
  end
end