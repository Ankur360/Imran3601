path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

 class AddJoinSessionPage < SupportHelper

   def initialize(driver)
     @driver = driver
   end

  def addSession()
    #click on change session
    clickOnChangeSession()
    #click on save schedule
    clickSaveSchedule()
    #click on join session
    clickJoinSession()
    #verify that user is on the correct session
    sessionName= verifySessionName()
  end

  #click on change session
  def clickOnChangeSession()
    el= @driver.find_element(:xpath, "//nav[@class='new-primary-nav']//a[contains(text(),'Change')]")
    el.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:xpath => "//span[contains(text(),'Join Conversation')]").displayed? }
  end


  #click SaveSchedule Button
  def clickSaveSchedule
    el=@driver.find_element(:xpath, "//span[contains(text(),'Save to My Schedule')]")
    el.click
  end

  #click JoinSession Link
  def clickJoinSession
    el= @driver.find_element(:xpath, "//span[contains(text(),'Join Conversation')]")
    el.click
  end

  #verify added session
  def verifySessionName()
     el= @driver.find_element(:class,"session-title-normal")
     sessionName=el.text
    # assert_equal sessionName,"Automation Session", "Automation title should be shown"
     sessionName
  end
 end

