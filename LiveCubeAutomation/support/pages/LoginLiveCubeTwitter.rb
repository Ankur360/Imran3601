path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class LoginLiveCubeTwitter < SupportHelper

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
   logout= verifyUserLoggedIn()
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

  # verify user logged into the live cube application
  def verifyUserLoggedIn
    el=@driver.find_element(:css, "a.x-btn-show-me").displayed?
    #assert_equal el,true, "User should be logged in livecube application"
    el

  end

#******************************** Forgot Password Functionality *****************************************
# login function
  def VerifyForgotPassword(emailAddress)
    clickOnSignIntoYourEvent()
    clickOnSignInWithTwitter()
    m1= verifyforgotPassFunctionality(emailAddress)
    m1

  end

  # ClickSubmit
  def clickSubmit
    @driver.find_element(:id, "lookup_user").click
    @driver.switch_to.window(main_window)
  end

  # ForgotPassword
  def verifyforgotPassFunctionality(emailAddress)
    message= moveToForgetPassWindow(emailAddress)
    message
  end

  #Move to forgot password and verify the functionality
  def moveToForgetPassWindow(emailAddress)
    #click on project view and move to next window
    forgotPass= @driver.find_element(:link, "Forgot password?")
    forgotPass.click
    main_window = @driver.window_handle
    windows = @driver.window_handles
    windows.each do |window|
      if main_window != window
        @new_window = window
      end
    end

    @driver.switch_to.window(@new_window)
    enterUserName(emailAddress)
    submit= @driver.find_element(:id, "lookup_user")
    submit.click
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element(:class => "resend-password-wrapper").displayed? }
    confirmMsg= @driver.find_element(:class, "resend-password-wrapper").text
    #assert confirmMsg.include? "We've sent password reset instructions to your email address."
    #switch back into main window
    @driver.switch_to.window(main_window)
    confirmMsg
  end

  # Enter User Name
  def enterUserName(emailAddress)
    el = @driver.find_element(:id, "email_or_phone")
    el.send_keys emailAddress
  end
end


























