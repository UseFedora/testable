require "capybara/cucumber"
require "selenium-webdriver"

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :chrome
  config.app_host = "http://takehome.zeachable.com"
end
