# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see (\d+) movies$/ do |movie_count|
  $ui_table = page.body
  $ui_row_count = $ui_table.scan(/<tr>/).length - 1
  $ui_row_count.should be movie_count.to_i
end
# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  $ui_table = page.body
  ($ui_table.index(e1.to_s) < $ui_table.index(e2.to_s)).should be true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/\s*,\s*/).each do |rating|
    if uncheck.nil?
      step %Q{I check "ratings_#{rating}"}
    else
      step %Q{I uncheck "ratings_#{rating}"}
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  $ui_table = page.body
  $ui_movie_count = $ui_table.scan(/<tr>/).length - 1
  $ui_movie_count.should be Movie.count
end
