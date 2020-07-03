Given("I am on the school homepage") do
  visit "/"
  expect(page).to have_link("Login")
end

When("I click Login link") do
  click_on "Login"
  expect(page).to have_text("Log In to takehome")
end

When("I fill my credential") do
  fill_in "Email Address", with: "ben+test3@example.com"
  fill_in "Password", with: "password"
  click_on "Log In"
end

Then("I should be logged in") do
  expect(page).to have_text("My Course")
  find("img.gravatar").click
  expect(page).to have_text("Edit Profile")
  expect(page).to have_text("Log Out")
end
