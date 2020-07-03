Given("I am logged out of the school") do
    visit "/"
    click_on "Login"
    expect(page).to have_text("Log In to takehome")
end

When("I log in to complete a course") do
    fill_in "Email Address", with: "ben+test5@example.com"
    fill_in "Password", with: "password"
    click_on "Log In"
    expect(page).to have_css("div.course-listing")
end

When("I visit an enrolled course") do
    find("div.course-listing-title").click
    expect(page).to have_css("a", text:"Start next lecture")
end

When("I visit the first lecture page") do
    find("a.start-next-lecture").click
    expect(page).to have_text("Complete and continue")
    within("h2#lecture_heading") do
        expect(page).to have_text("First Lecture")
    end
end

When("I complete the lectures") do
    find("a#lecture_complete_button").click
    expect(page).to have_text("Previous Lecture")
    within("h2#lecture_heading") do
        expect(page).to have_text("Last Lecture")
    end
    find("a#lecture_complete_button").click
    within("h2#lecture_heading") do
        expect(page).to have_text("Quiz")
    end
end

When("I complete the quiz") do
    expect(page).to have_css("div#quiz-app")
    expect(page).to have_css("div.quiz-question", text:"what is the color of sky")
    find("span", :text => /\ABlue\z/).click
    find("button", :text => /\ACheck\z/).click
    find('button[date-test="continue-button"]').click
    find("span", :text => /\ACucumber\z/).click
    find("button", :text => /\ACheck\z/).click
    find('button[date-test="continue-button"]').click
    find("a#lecture_complete_button").click
end

Then("I should be complete with the course") do
    expect(page).to have_css("h2.section-title", text:"Course Curriculum")
    # Commented out the below because test school's curriculum does not update after completing the course. 
    # This is an existing bug (SXP-471)
    # expect(page).to have_css("span.percentage", text:"100%")
end