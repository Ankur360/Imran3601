path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

 class LoginLiveCubeFirstTimeTwitter < SupportHelper

    def initialize(driver)
       @driver = driver
    end
  
    #login function
    def loginToApplication(emailAddress, password)
      # verifyLoginWindow()
      clickOnSignIntoYourEvent()
      clickOnSignInWithTwitter()
      enterTwitterEmail(emailAddress)
      enterTwitterPassword(password)
      clickSignIn()
      clickOnAuthorize()
      team= verifyTeamDisplayed()
      clickOnTeam()
      logout= verifyUserLoggedIn()
      return [team, logout]
    end

    # click Sign Into your Event button
    def clickOnSignIntoYourEvent()
      e1= @driver.find_element(:xpath, "//span[text()='Sign Into Your Event']")
      e1.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:xpath => "//span[contains(text(),'Sign In with Twitter')]").displayed? }
    end

    # click Sign In with Twitter Button
    def clickOnSignInWithTwitter
      el= @driver.find_element(:xpath, "//span[contains(text(),'Sign In with Twitter')]")
      el.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:id => "oauth_form").displayed? }
    end

    # enter twitter email address
    def enterTwitterEmail(emailAddress)
      el = @driver.find_element(:id, "username_or_email")
      el.clear
      el.send_keys emailAddress
     end

     # enter twitter password
    def enterTwitterPassword(password)
      el = @driver.find_element(:id, "password")
      el.clear
      el.send_keys password
    end

    # Click on sign in Button
    def clickSignIn
      el= @driver.find_element(:id,"allow")
      el.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:xpath => "//input[@value='Authorize app']").displayed? }
    end

    #click on authorize app button
    def clickOnAuthorize()
      e2= @driver.find_element(:xpath,"//input[@value='Authorize app']")
      e2.click
    end

   #verify that team list at very first time when user open attendees URL
   def verifyTeamDisplayed()
     el= @driver.find_element(:xpath, "//h3[text()='Automation Team']")
     teamName= el.text
    # assert_equal teamName, "Automation Team"
   end

   #click on team
    def clickOnTeam()
     el= @driver.find_element(:xpath, "//h3[text()='Automation Team']/preceding-sibling::a")
     el.click
     acceptPopup()
     wait = Selenium::WebDriver::Wait.new(:timeout => 10)
     wait.until { @driver.find_element(:id => "livecube-nanobar").displayed? }
   end

   #accept the team
   def acceptPopup()
     a = @driver.switch_to.alert
     if a.text == 'Are you sure?'
       a.accept
     else
       a.dismiss
     end
   end
   # verify user logged into the live cube application

   def verifyUserLoggedIn
     el=@driver.find_element(:css, "a.x-btn-show-me").displayed?
    # assert_equal el,true, "User should be logged in livecube application"
   end
end
