
path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

 class ForgotPasswordPage < SupportHelper

  def initialize(driver)
    @driver = driver
  end

  # login function
  def verifyForgotPass(username)
    clickSignIntoYourEvent()
    clickSignInWithTwitter()
    verifyforgotPassFunctionality(username)

  end

  # ClickSignIntoYourEvent
  def clickSignIntoYourEvent
    @driver.find_element(:css, "span.text").click
  end

  # ClickSignInWithTwitter
  def clickSignInWithTwitter
    @driver.find_element(:css, "i.fui-twitter").click
  end

  # ClickSubmit
  def clickSubmit
    @driver.find_element(:id, "lookup_user").click
    @driver.switch_to.window(main_window)
  end

  # ForgotPassword
  def verifyforgotPassFunctionality(userType)
    moveToForgetPassWindow(userType)
  end

  #Move to forgot password and verify the functionality
  def moveToForgetPassWindow(userType)
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
      enterUserName(userType)
      submit= @driver.find_element(:id, "lookup_user")
      submit.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:class => "resend-password-wrapper").displayed? }
      confirmMsg= @driver.find_element(:class, "resend-password-wrapper").text
      #assert confirmMsg.include? "We've sent password reset instructions to your email address."
      #switch back into main window
      @driver.switch_to.window(main_window)
  end

  # Enter User Name
  def enterUserName(userType)
    el = @driver.find_element(:id, "email_or_phone")
    el.send_keys userType
  end

end

