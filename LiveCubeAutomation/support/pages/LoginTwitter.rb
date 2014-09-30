path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

 class LoginTwitter < SupportHelper

    def initialize(driver)
       @driver = driver
    end
  
    #login function
    def loginToApplication(username)
      # verifyLoginWindow()
      clickOnSignIntoYourEvent()
      clickOnSignInWithTwitter()
      enterUserName(username)
      enterPassword(username)
      clickSignIn()
    end

     # click Sing Into Your Event Link
    def clickOnSignIntoYourEvent
     el= @driver.find_element(:css, "span.text")
     el.click
    end

    # click Sign In with Twitter Button
    def clickOnSignInWithTwitter
      el= @driver.find_element(:css, "i.fui-twitter")
      el.click
    end

    # enter Username
    def enterUserName(userType)
      cc = ReadConfig.new()
      el = @driver.find_element(:id, "username_or_email")
      el.send_keys cc.getApplication(userType+'USER')
      el = @driver.find_element(:id, "username_or_email").text

     end

     # enter Password
    def enterPassword(userType)
      cc = ReadConfig.new()
      el = @driver.find_element(:id, "password")
      el.send_keys cc.getApplication(userType+'Pass')
    end

    # Click on sign in Button
    def clickSignIn
      el= @driver.find_element(:xpath,"//input[@value='Sign In']")
      el.click
      waitAuthorizeApp()
      e2= @driver.find_element(:xpath,"//input[@value='Authorize app']")
      e2.click
    end

    # Verify Login Account
    def verifyTwitterAccount
       sleep(5)
       el= @driver.find_element(:css, "img.top-avatar-img")
       el.click
       message = @driver.find_element(:class, "attendee-name").text
       #assert message.include? "Qwerty"
    end

    def waitAuthorizeApp()
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:xpath => "//input[@value='Authorize app']").displayed? }
    end

 end























