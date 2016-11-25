require 'test_helper'

module Minitest::Reporters
  class OrderReporterTest < Minitest::Test
    include ReporterTestHelper

    def setup
      @reporter = OrderReporter.new(path: log_path)
      @reporter.start
    end

    def test_record
      @reporter.record(runnable('a'))
      @reporter.record(runnable('b'))
      @reporter.report
      assert_equal ['Minitest::Test#a', 'Minitest::Test#b'], File.readlines(log_path).map(&:chomp)
    end

    private

    def delete_log
      File.delete(log_path) if File.exists?(log_path)
    end

    def log_path
      @path ||= File.join(Dir.tmpdir, 'test_order.log')
    end
  end
end
