# frozen_string_literal: true

Given(/the following movies exist/) do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then(/I should see "(.*)" before "(.*)"/) do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When(/I (un)?check the following ratings: (.*)/) do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %(I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}")
  end
end

Then(/I should see all the movies/) do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.find_each do |movie|
    step %(I should see "#{movie.title}")
  end
end

When('I go to the edit page for {string}') do |string|
  visit edit_movie_path(Movie.find_by(title: string))
end

When('I fill in {string} with {string}') do |string, string2|
  fill_in string, with: string2
end

When('I press {string}') do |string|
  click_button string
end

Then('the director of {string} should be {string}') do |string, string2|
  expect(Movie.find_by(title: string).director == string2).to be true
end

Given('I am on the details page for {string}') do |string|
  visit movie_path(Movie.find_by(title: string))
end

When('I follow {string}') do |string|
  click_link(string)
end

Then('I should be on the Similar Movies page for {string}') do |string|
  expect(show_by_director_path(Movie.find_by(title: string))).to eq current_path
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end

Then('I should be on the home page') do
  expect(page).to have_current_path(movies_path)
end

Given('I am on details page for {string}') do |string|
  visit movie_path(Movie.find_by(title: string))
end

When('I am following {string}') do |string|
  click_link(string)
end

Then('I should be on Similar Movies page for {string}') do |string|
  expect(sort_by_rating_path(Movie.find_by(title: string))).to eq current_path
end

Then('I should find {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should not find {string}') do |string|
  expect(page).not_to have_content(string)
end

Then('I should be on home page') do
  expect(page).to have_current_path(movies_path)
end
