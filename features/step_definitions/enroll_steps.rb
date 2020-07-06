Given("I am not enrolled in the school") do
    # Global variable in test might not be best practice, but I couldn't figure out a better way of getting around creating an account that doesn't already exist
    # This will generate a 5 character string from [A..9]
    $email="ben+#{rand(36**5).to_s(36)}@example.com"
    visit "/"
    click_on "Sign Up"
    expect(page).to have_text("Sign Up to takehome")
end

When("I sign up to the school") do
    fill_in "Full Name", with: "Ben"
    fill_in "Email Address", with: $email
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    check "user_unsubscribe_from_marketing_emails"
    check "user_agreed_to_terms"
    click_on "Sign Up"
    expect(page).to have_css("div.course-listing")
end

When("I click on course box") do
    find('div.course-listing-title').click
    expect(page).to have_css("h1", text:"My Awesome Course")
end

When("I click on enroll button") do
    find("button#enroll-button-top").click
    expect(page).to have_css("h1", text:"Thanks for enrolling in this course!")
end

Then("I should be enrolled in course") do
    expect(page).to have_css("p", text:"Your order ID: ")
    find("a.goto-course").click
    expect(page).to have_css("h2", text:"Course Curriculum")
    expect(page).to have_css("a", text:"Start next lecture")
end