require_relative 'watir_helper'
include WatirHelper

Before do |scenario|
    @browser = WatirHelper.browser
end

After do |scenario|
    @browser.quit
end

Given("I at homepage") do
    @browser.goto(ENV['URI'])
    expect(@browser.url).to include(ENV['URI'])
end

Given("I click button with text {string}") do |string|
    @browser.element(:text, string).click
end

Given("I fill the credential") do
    # This email var will generated uniquely every test run
    email = ENV['EMAIL'].gsub(/@/, "+#{Time.now.to_i}@")

    @browser.text_field(:id, 'user_name').set(ENV['FNAME'])
    @browser.text_field(:id, 'user_email').set(email)
    @browser.text_field(:id, 'user_password').set(ENV['PASSWORD'])
    @browser.text_field(:id, 'user_password_confirmation').set(ENV['PASSWORD'])
    @browser.checkbox(:id, 'user_unsubscribe_from_marketing_emails').set
    @browser.checkbox(:id, 'user_agreed_to_terms').set
end

When("I click {string} button") do |string|
    @browser.element(:value, string).click
    sleep 10
end

Then("I should see {string} course on My Courses page") do |string|
    expect(@browser.text.include?(string)).to be true
end

