Given(/^I am on the sign up page$/) do
  visit '/sign_up'
  expect(page).to have_current_path(/sign_up/)
end

When(/^I enter all required information and register$/) do
  # test data
  first_name = random_string(8)
  last_name = random_string(6)
  full_name = "#{first_name} #{last_name}"
  email_address = "#{first_name}.#{last_name}@testmail.com"
  password = 'test123456'

  expect(page).to have_content("Sign Up to takehome")
  # full name text field
  fill_in "user_name", with: full_name
  # email text field
  fill_in "user_email", with: email_address
  # checkbox
  check("user_unsubscribe_from_marketing_emails")
  # password
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password
  # checkbox
  check("user_agreed_to_terms")
  # click sign up
  click_on("Sign Up")
  # validate that I am on dashboard page
  expect(page).to have_css(".course-listing")
end

def random_string(num)
  (0...num.to_i).map {('a'..'z').to_a[rand(26)]}.join
end

When(/^I enroll in a course with name "([^"]*)"$/) do |course_name|
  click_on(course_name)
  expect(page).to have_css('#enroll-button-top')
  page.find("#enroll-button-top").click
  expect(page).to have_content("Thanks for enrolling in this course!")
end

Then(/^I verify that I can complete the course$/) do
  click_link("Continue to Course")
  expect(page).to have_content("Class Curriculum")
  click_link("Start next lecture")
  page_header = page.find("#lecture_heading")
  expect(page_header).to have_content("Lecture with text")
  click_link("Complete and continue")
  expect(page_header).to have_content("Lecture with video")
  click_link("Complete and continue")
  expect(page_header).to have_content("Lecture with pdf")
  click_link("Complete and continue")
  expect(page_header).to have_content("Lecture with text")
  find("#lecture_complete_button").click
  within(find(".course-sidebar")) do
    step 'I should see "100% COMPLETE"'
  end
end

Then(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text), "expect #{text} but did not find it current page"
end