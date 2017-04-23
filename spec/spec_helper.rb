require "bundler/setup"
require "puppet_factset"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

EXTRA_FACT_KEY      = "extra_fact"
EXTRA_FACT_VALUE    = "this is an extra fact"
OVERRIDE_FACT_VALUE = "fakeos"
MERGED_DIR          = "spec/fixtures/merged"
UNMERGED_DIR        = "spec/fixtures/unmerged"
