require 'selenium-webdriver'
require 'rspec/expectations'
require './lab_components_object'
include RSpec::Matchers

def setup(browser_name, platform)
  caps = Selenium::WebDriver::Remote::Capabilities.new
  puts "Before case, browser name is #{browser_name}, platform name is #{platform}"
  case (platform)
    when "windows"
      caps[:platform] = "Windows"
      case (browser_name)
        when :firefox
          caps[:browserName] = :firefox
        when :chrome
          caps[:browserName] = :chrome
        when :ie
          caps[:browserName] = 'internet explorer'
      end
    when "mac"
      caps[:platform] = 'OS X'
      case (browser_name)
        when :firefox
          caps[:browserName] = :firefox
        when :chrome
          caps[:browserName] = :chrome
        when :safari
          caps[:browserName] = :safari
      end
  end
  @driver = Selenium::WebDriver.for(
      :remote,
      :url=> 'http://localhost:4444/wd/hub',
      :desired_capabilities=> caps )
  #setupHelper(@driver.session_id)
  ENV['base_url'] = 'http://lab.concord.org/interactives-staging.html#interactives/interaction-tests/components.json'
  puts "platform is #{@driver.capabilities.platform}, browser is #{@driver.capabilities.browser_name}"
rescue Exception => e
  puts e.message
  puts "Could not start driver #{@browser_name}"
  exit 1
end


def teardown
  puts "in teardown"
  @driver.quit
end

MACBROWSERS = [:chrome, :firefox]
WINBROWSERS = [:firefox, :chrome, :ie]

def run


=begin
  MACBROWSERS.each do |macbrowser|
    puts macbrowser
    setup(macbrowser, "mac")
    yield
    #teardown
  end
=end

  WINBROWSERS.each do |winbrowser|
    puts winbrowser
    setup(winbrowser, "windows")
    yield
    #teardown
  end

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
   interactive.play_click
   interactive.pause_click
   interactive.reset_click
   interactive.reload
end
