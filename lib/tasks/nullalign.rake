namespace :nullalign do
  desc "Generate a migration to fix issues nullalign found"
  task fix: :environment do
    Nullalign.generate_migration
  end
end