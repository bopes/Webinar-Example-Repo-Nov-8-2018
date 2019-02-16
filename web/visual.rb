require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'browserstack/local'

class ParallelTest < Test::Unit::TestCase

  def setup
  	caps = Selenium::WebDriver::Remote::Capabilities.new
		caps["browser"] = ENV['browser']
		caps["browser_version"] = ENV['browser_version']
		caps["os"] = ENV['os']
		caps["os_version"] = ENV['os_version']

		if ENV['browser'] != "Internet Explorer"
			browser_name = "#{ENV['browser'].capitalize} #{ENV['browser_version']}"
		else
			browser_name = "Internet Explorer #{ENV['browser_version']}"
		end

		caps['project'] = "BrowserStack"
		caps['build'] = "Webinar"
		caps['name'] = "Visual Test: " + browser_name

		caps["browserstack.debug"] = "true"

    url = "http://#{ENV["BROWSERSTACK_USER"]}:#{ENV["BROWSERSTACK_ACCESSKEY"]}@hub-cloud.browserstack.com/wd/hub"
    @driver = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => caps)

  end

  def test_post
		@driver.navigate.to 'http://www.browserstack.com'
		title = @driver.title
		@driver.save_screenshot('web/screenshots/' + ENV['browser'] + '.png')
    assert_equal(title, title)
  end

  def teardown
    @driver.quit
  end
  
end
