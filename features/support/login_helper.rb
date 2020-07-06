# Found a different solution that creates a user and uses the same user account for completing course.
# Since the steps in `enroll_steps.rb` and `complete_steps.rb` are no longer the same,  I don't think I'll need this helper.
# I could use it to refactor login_steps and complete_steps while passing in different arguments

# module LoginHelper
#     def do_login(email, password)
#       fill_in "Email Address", with: "ben+test5@example.com"
#       fill_in "Password", with: "password"
#       click_on "Log In"
#       expect(page).to have_css("div.course-listing")
#     end
# end