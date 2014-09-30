path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class UserActivityPage < SupportHelper

  def initialize(driver)
    @driver = driver
  end

#Verify user activity at user>>activity section

  def verifyActivity(url)
    clickOnShowMe()
    clickOnActivity()
    verifyActivityTitle()
    verifyPostedMessage()
    refreshPage(url)
  end


  def clickOnShowMe()
    el= @driver.find_element(:css, "a.x-btn-show-me")
    el.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:link => "Activity Feed").displayed? }
  end

  def clickOnActivity()
    el= @driver.find_element(:link, "Activity Feed")
    el.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:id => "me-activity").displayed? }

  end

  def verifyActivityTitle()
    el= @driver.find_element(:xpath, "//div[@class='bubble-top']/h2")
    activityTitle= el.text
    assert_equal "Activity", activityTitle, "Title should be shown activity"
  end

  def verifyPostedMessage()
    el= @driver.find_element(:xpath, "//div[contains(text(),'This is my fist post of automation')]")
    postMessage= el.text
    assert postMessage.include? "This is my fist post of automation"

  end

  def refreshPage(url)
    @driver.get url

  end

#*******************************Update user profile***********************************
  def updateUserProfile()
    clickOnShowMe()
    clickOnEditProfile()
    editUserInfo()
    clickOnSave()
    verifyProfileUpdated()
  end

  def clickOnMe()
    el= @driver.find_element(:xpath, "//a[contains(text(),'Edit Profile')]")
    el.click
  end

  def clickOnEditProfile()
    el= @driver.find_element(:xpath, "//a[contains(text(),'Edit Profile')]")
    el.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:xpath => "//h2[text()='Update Center']").displayed? }
    sleep(6)
  end

  #edit name, title and company name
  def editUserInfo()
    nm= @driver.find_element(:id, "attendee_name")
    nm.clear
    nm.send_keys "User360"

    title= @driver.find_element(:id, "attendee_title")
    title.clear
    title.send_keys "Title360"

    comp= @driver.find_element(:id, "attendee_company")
    comp.clear
    comp.send_keys "company360"
  end

  def clickOnSave()
    save= @driver.find_element(:xpath, "//input[@value='Save Changes']")
    save.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:xpath => "//a[contains(text(),'Edit Profile')]").displayed? }
  end

  def verifyProfileUpdated()
    name= @driver.find_element(:class, "attendee-name").text
    #assert name.include? "User360"

    title= @driver.find_element(:class, "attendee-title").text
    #assert title.include? "Title360"

    comp= @driver.find_element(:class, "attendee-company").text
    #assert comp.include? "company360"
  end
end




