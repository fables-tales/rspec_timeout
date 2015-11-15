require "rspec_timeout/version"

module RSpecTimeout
  TIMEOUT_OPTS_DEFAULTS = { :timeout => 120 }.freeze

  SIGNAL_LEVEL = "HUP"

  def self.setup(rspec_config, timeout_opts=TIMEOUT_OPTS_DEFAULTS)
    timeout = timeout_opts.fetch(:timeout)
    timeout_string = "RSpec timeout killed your test suite because it took longer than #{timeout} seconds to run"
    setup_after_suite_hook(rspec_config)
    setup_before_suite_hook(rspec_config, timeout, timeout_string)
  end

  def self.setup_before_suite_hook(rspec_config, timeout, timeout_string)
    setup_timeout_process(timeout)
    setup_exit_signal_handler(timeout, timeout_string)
  end

  def self.setup_after_suite_hook(rspec_config)
    rspec_config.after(:suite) do
      Process.kill(SIGNAL_LEVEL, $rspec_timeout_fork)
    end
  end

  private

  def self.setup_timeout_process(timeout)
    parent_pid = Process.pid
    $rspec_timeout_fork = fork do
      sleep(timeout)
      Process.kill(SIGNAL_LEVEL, parent_pid)
    end
  end

  def self.setup_exit_signal_handler(timeout, timeout_string)
    Signal.trap(SIGNAL_LEVEL) do
      at_exit do
        spam(timeout_string.length)
        puts timeout_string
        spam(timeout_string.length)
      end

      exit(1)
    end
  end

  def self.spam(length)
    10.times do
      puts "!" * length
    end
  end
end
