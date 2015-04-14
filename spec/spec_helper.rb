require 'coveralls'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'valid_attribute'
require 'sidekiq/testing'

Coveralls.wear!('rails')

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

# RSpec::Sidekiq.configure do |config|
#   # Clears all job queues before each example
#   config.clear_all_enqueued_jobs = true # default => true
#
#   # Whether to use terminal colours when outputting messages
#   config.enable_terminal_colours = true # default => true
#
#   # Warn when jobs are not enqueued to Redis but to a job array
#   config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
# end
