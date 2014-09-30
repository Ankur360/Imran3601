path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class MorePage < SupportHelper

  def initialize(driver)
    @driver = driver
  end

  #At information page verify that content are shown properly
  def verifyInformationScreen()
    clickOnMoreTab()
    clickOnInformation()
    verifyMeeting()
  end

  #Click on more tab
  def clickOnMoreTab()
    el= @driver.find_element(:link, "More")
    el.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:id => "popup-menu").displayed? }
  end

  #
  def clickOnInformation()
    el= @driver.find_element(:link, "Information")
    el.click
  end

  def verifyMeeting()
    el= @driver.find_element(:class, "meeting-title")
    meetingName= el.text
    #assert_equal meetingName, "Automation Meeting"
  end

end




