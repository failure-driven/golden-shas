# frozen_string_literal: true

require "capybara/rspec"
require "capybara/rails"
require "capybara-inline-screenshot/rspec"

module SlomoBridge
  TIMEOUT = ENV.fetch("SLOMO_MS", "0").to_i / 1000.0

  def execute(*)
    sleep TIMEOUT if TIMEOUT > 0
    super
  end
end

# Don't wait too long in `have_xyz` matchers
Capybara.default_max_wait_time = 2 # the default is 2

Capybara.javascript_driver = :selenium_chrome

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  if ENV.fetch("GITHUB_ACTIONS", nil) == "true"
    options.add_argument("--headless")
    options.add_argument("--disable-gpu")
  end

  args = {browser: :chrome}
  args[:options] = options if options
  Capybara::Selenium::Driver.new(
    app,
    **args
  ).tap do |driver|
    # Enable slomo mode
    driver.browser.send(:bridge).singleton_class.prepend(SlomoBridge)
  end
end

Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.add_selector(:qa) do
  css { |name| %([data-testid="#{name}"]) }
end
