require "capybara/cucumber"
require "selenium-webdriver"
require "pry"

# monkey patch to avoid reset sessions
class Capybara::Selenium::Driver < Capybara::Driver::Base
  def reset!
    @browser.navigate.to('about:blank') if @browser
  end
end

Capybara.default_selector = :css
Capybara.default_max_wait_time = 30
Capybara.ignore_hidden_elements = true
Capybara.app_host = "https://takehome.zeachable.com/"
Capybara.run_server = false
Capybara.default_driver = :chrome

Capybara.register_driver :chrome do |app|
  options = {
      :js_errors => false,
      :timeout => 360,
      :debug => false,
      :inspector => false,
  }
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
