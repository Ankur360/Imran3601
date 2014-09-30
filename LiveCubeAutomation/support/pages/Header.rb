path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class Header < SupportHelper

  def initialize(driver)
	@driver = driver
  end

  #Logout from the organizer application
  def logOut
	  @driver.find_element(:css, "span.fui-power.x-btn-icon").click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:class => "organizer-form").displayed? }
  end

end
