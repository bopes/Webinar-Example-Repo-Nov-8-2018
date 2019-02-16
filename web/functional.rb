require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'browserstack/local'

class SingleTest < Test::Unit::TestCase

  def setup
		url = "http://#{ENV["BROWSERSTACK_USER"]}:#{ENV["BROWSERSTACK_ACCESSKEY"]}@hub-cloud.browserstack.com/wd/hub"

		caps = Selenium::WebDriver::Remote::Capabilities.new
		caps['browser'] = 'Chrome'
		caps['browser_version'] = '70.0'
		caps['os'] = 'OS X'
		caps['os_version'] = 'High Sierra'

		caps['project'] = "BrowserStack"
		caps['build'] = "Webinar"
		caps['name'] = "Functional Test"

		caps["browserstack.debug"] = true
		caps["browserstack.console"] = "verbose"
    
		@driver = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => caps)
		@driver.manage.timeouts.implicit_wait = 10

  end

  def test_post
		@driver.navigate.to 'http://www.google.com'

		search_bar = @driver.find_element(:name, "q")
		search_bar.send_keys 'BrowserStack'
		search_bar.submit

		first_result = @driver.find_element(:css, "h3.r a")
		first_result.click

		title = @driver.title

    assert_equal(title, title)
  end

  def teardown
    @driver.quit
  end
  
end
