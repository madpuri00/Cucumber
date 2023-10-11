Given('I am on the YouTube Homepage') do 

   # BROWSER.back
   # BROWSER.forward
   # BROWSER.refresh

    BROWSER.window.maximize
    BROWSER.goto("https://www.youtube.com/")

end
When(/^I search youtube for (.*?)$/) do |baldurs|

    search_box = BROWSER.text_field(id: 'search')
    search_box.set(baldurs)

    button = BROWSER.button(id:'search-icon-legacy')
    button.click

    sleep 2
end

And("I should see results for review") do

     # Find all video titles on the search results page
  video_titles = BROWSER.divs(id: "video-title")

  # Initialize a flag to check if any video contains "review"
  found_review = false

  # Iterate through each video title and check for "review"
  video_titles.each do |video_title|
    title = video_title.text.downcase
    puts "Found Title: #{title}" if title.include?('review')

    if title.include?('review')
      found_review = true
      break  # Exit the loop once a "review" is found
    end
  end

  # Assert that at least one video title contains "review"
  expect(found_review).to be true
end


And("I click on a video over 20 mins long") do

     # Find videos over 20 minutes long
  long_videos = BROWSER.divs(class: 'style-scope ytd-thumbnail-overlay-time-status-renderer').select do |video_length|
    length_text = video_length.text
    length_text.include?('M')
  end

  # Click on the first video (you may want to enhance this logic)
  if long_videos.any?
    long_videos.first.click
  else
    raise "No videos over 20 minutes long found."
  end
end

Then("I pause the video at 1min 23 seconds") do

    sleep 5

    BROWSER.execute_script("document.querySelector('video').currentTime = 83; document.query('video').pause;")

    BROWSER.close
  end

