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
    @email = ENV['EMAIL'].gsub(/@/, "+#{Time.now.to_i}@")

    @browser.text_field(:id, 'user_name').set(ENV['FNAME'])
    @browser.text_field(:id, 'user_email').set(@email)
    @browser.text_field(:id, 'user_password').set(ENV['PASSWORD'])
    @browser.text_field(:id, 'user_password_confirmation').set(ENV['PASSWORD'])
    @browser.checkbox(:id, 'user_unsubscribe_from_marketing_emails').set
    @browser.checkbox(:id, 'user_agreed_to_terms').set
end

When("I click {string} button") do |string|
    @browser.element(:value, string).click
end

When("I see {string} course on My Courses page") do |string|
    expect(@browser.text.include?(string)).to be true
    expect(@browser.element(:class, 'course-listing-title').text).to eql(string)
end

When("I click {string} course") do |string|
    course_title = @browser.element(:class, 'course-listing-title')
    course_title.click if course_title.text.eql? string
    expect(@browser.element(:class, 'course-title').text).to eql(string)

    @browser.element(:id, 'enroll-button-top').click
    expect(@browser.text.include? 'Thanks for enrolling in this course!').to be true
    expect(@browser.text.include? @email ).to be true
    @browser.element(:css,'a.btn.btn-hg.btn-primary.btn-inline-block.goto-course').click
    
end

When("I complete the all the course") do
    lecture_urls = []
    percentage = 0
    lecture_elements = @browser.elements(:class, 'section-item')
    lecture_elements.each {|l| lecture_urls << l.a.href}

    @browser.element(:css, 'body > div.course-mainbar > div.next-lecture-wrapper > a').click()
    lecture_urls.each do |url|
        inc = (100 / lecture_urls.count.to_i)
        puts percentage
        @browser.goto(url) unless @browser.url.eql? url
        @browser.element(:id, 'lecture_complete_button').click
        puts percentage = percentage + inc
        Watir::Wait.until { sleep(3) or @browser.element(:class, 'percentage').text.include? "#{percentage}%" }
        puts @browser.element(:class, 'percentage').text
        expect(@browser.element(:class, 'percentage').text).to eql("#{percentage}%")
        # Will be fail here since I cought a bug that precentage show 0% not 100%
        # check screenshot attached on the email
    end
end

Then("I should see all my lecture completed") do
    expect(@browser.element(:class, 'percentage').text).to eql("100%")
end