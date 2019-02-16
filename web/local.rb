require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'browserstack/local'

class LocalTest < Test::Unit::TestCase

  def setup
    caps = Selenium::WebDriver::Remote::Capabilities.new
		caps['browser'] = 'IE'
		caps['browser_version'] = '11.0'
		caps['os'] = 'Windows'
		caps['os_version'] = '10'

		caps['project'] = "BrowserStack"
		caps['build'] = "Webinar"
		caps['name'] = "Local Test"

		caps["browserstack.debug"] = "true"
		caps["browserstack.local"] = "true"

		bs_local_args = { "key" => "#{ENV["BROWSERSTACK_ACCESSKEY"]}", "forcelocal" => true, "force" => true }
		@bs_local = BrowserStack::Local.new
		@bs_local.start(bs_local_args)

    url = "http://#{ENV["BROWSERSTACK_USER"]}:#{ENV["BROWSERSTACK_ACCESSKEY"]}@hub-cloud.browserstack.com/wd/hub"
    @driver = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => caps)
		@driver.manage.timeouts.implicit_wait = 10
  end

  def test_post
		@driver.navigate.to "http://localhost:8000"
    title = @driver.title()
    assert_equal("Local Server", title)
  end

  def teardown
    @driver.quit
    @bs_local.stop unless @bs_local.nil?  
  end
  
end
