require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'browserstack/local'

class MobileTest < Test::Unit::TestCase

  def setup
  	caps = Selenium::WebDriver::Remote::Capabilities.new
		caps["device"] = ENV['device']
		caps["os_version"] = ENV['os_version'] if ENV['os_version']
		caps["realMobile"] = true

		caps['project'] = "BrowserStack"
		caps['build'] = "Webinar"
		caps['name'] = "Mobile Compatibility Test: " + caps['device']

		caps["browserstack.debug"] = "true"

    url = "http://#{ENV["BROWSERSTACK_USER"]}:#{ENV["BROWSERSTACK_ACCESSKEY"]}@hub-cloud.browserstack.com/wd/hub"
    @driver = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => caps)
		@driver.manage.timeouts.implicit_wait = 10
  end

  def test_post
		@driver.navigate.to 'http://www.browserstack.com'
		title = @driver.title
    assert_equal(title, title)
  end

  def teardown
    @driver.quit
  end
  
end
