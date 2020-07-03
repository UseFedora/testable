# Given("I am on the course directory") do 
#     visit "/courses"
#     expect(page).to have_css(".course-listing")
# end

Given("I am logged out") do
    visit "/"
    click_on "Login"
    expect(page).to have_text("Log In to takehome")
    fill_in "Email Address", with: "ben+test3@example.com"
    fill_in "Password", with: "password"
    click_on "Log In"
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