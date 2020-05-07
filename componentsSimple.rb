require 'selenium-webdriver'
require 'rspec/expectations'
require './lab_components_object'
include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for :ie
  @driver.get 'http://lab.concord.org/interactives-staging.html#interactives/interaction-tests/components.json'
  ENV['base_url'] = 'http://lab.concord.org/interactives-staging.html#interactives/interaction-tests/components.json'
rescue Exception => e
  puts e.message
  puts "Could not start driver #{@browser_name}"
  exit 1
end


def teardown
  puts "in teardown"
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  puts "in Run. Driver is #{@driver}"
  interactive = LabComponentsObject.new(@driver)
  puts "interactive is #{interactive}"
  interactive.button_click
  interactive.slider_move
  interactive.dropdown_select_2
  interactive.dropdown_select_1
  interactive.check_box
  interactive.vradio_select_2
  interactive.vradio_select_1
  interactive.vradio_select_3
  interactive.hradio_select_2
  interactive.hradio_select_1
  interactive.hradio_select_3
  interactive.text_click
  interactive.image_click
  interactive.uncheck_box
  interactive.reload
end
