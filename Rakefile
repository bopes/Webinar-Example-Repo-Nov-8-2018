require 'json'

# Prep ENV
ENV['BROWSERSTACK_USER'] = XXXX
ENV['BROWSERSTACK_ACCESSKEY'] = XXXX

browser_list = File.read('web/browsers/browsers.json')
browsers = JSON.parse(browser_list)['browsers']

device_list = File.read('web/browsers/devices.json')
devices = JSON.parse(device_list)['devices']


# Automate - Functional Test

		task :functional do
			system "ruby web/functional.rb"
		end

# Automate - Compatibility Tests

		def run_parallel_compatibility_test(browser)
			command =  "os=\"#{browser['os']}\" "
			command += "os_version=\"#{browser['os_version']}\" "
			command += "browser=\"#{browser['browser']}\" "
			command += "browser_version=\"#{browser['browser_version']}\" "
			command += "ruby web/compatibility.rb"
			system command
		end

		parallel_compatibility_tests = Array.new

		browsers.each_with_index do |browser, i|
			eval "parallel_compatibility_tests << :parallel_compatibility_test_#{i}"
			eval "task :parallel_compatibility_test_#{i} do run_parallel_compatibility_test(#{browser}) end"
		end

		multitask :compatibility => parallel_compatibility_tests

# Automate - Visual Inspection

		def run_parallel_visual_test(browser)
			command =  "os=\"#{browser['os']}\" "
			command += "os_version=\"#{browser['os_version']}\" "
			command += "browser=\"#{browser['browser']}\" "
			command += "browser_version=\"#{browser['browser_version']}\" "
			command += "ruby web/visual.rb"
			system command
		end

		parallel_visual_tests = Array.new
		
		browsers.each_with_index do |browser, i|
			eval "parallel_visual_tests << :parallel_visual_test_#{i}"
			eval "task :parallel_visual_test_#{i} do run_parallel_visual_test(#{browser}) end"
		end

		multitask :visual => parallel_visual_tests

# Automate - Performance Testing

		task :performance do
			system 'ruby web/performance.rb'
		end

# Automate - Local Test

		task :local do
			system "ruby web/local.rb"
		end

# Automate - Mobile Web tests

		def run_mobile_test(device)
			command = "device=\"#{device['device']}\" "
			command += "os_version=\"#{device['os_version']}\" " if device['os_version']
			command += "ruby web/mobile.rb"
			system command
		end

		mobile_tests = Array.new

		devices.each_with_index do |device, i|
			eval "mobile_tests << :mobile_test_#{i}"
			eval "task :mobile_test_#{i} do run_mobile_test(#{device}) end"
		end

		multitask :mobile => mobile_tests
