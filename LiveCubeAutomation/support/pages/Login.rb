path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class Login < SupportHelper

    def initialize(driver)
    @driver = driver
    end


    #login into organizer application
    def loginToOrganizerApp(emailAddress,password)
    #After launching the browser verify that user landed on login screen
    #verifyLoginForm()
    enterEmail(emailAddress)
    enterPassword(password)
    clickOnSignIn()
    #Verify that user login into the application successfully
    #logoutButtonDisplayed()
    end

    def verifyLoginFormAfterOpenURL()
      logout= verifyLoginForm()
      logout

    end

    #verify organizer login form
    def verifyLoginForm
      result= element_present?(:class, "organizer-form")
      puts "logout button shown: #{result}"
      result
    end

    #Enter organizer email address
    def enterEmail(emailAddress)
      @driver.find_element(:id, "organizer_email").clear
      el=@driver.find_element(:id, "organizer_email")
      el.send_keys emailAddress
    end

    #Enter organizer password
    def enterPassword(password)
      @driver.find_element(:id, "organizer_password").clear
      el=@driver.find_element(:id, "organizer_password")
      el.send_keys password
    end
  
    #click on sign link
    def clickOnSignIn
      signLink=  @driver.find_element(:name, "commit")
      signLink.click
    end

    #verify logout button is shown
    def logoutButtonDisplayed()
      #assert element_present?(:class, "indicator-connection")
      result= element_present?(:class, "indicator-connection")
      result
    end



    #verify that signEvent label is shown
    def verifySignEventLabel
     # assert element_present?(:xpath, "//*[@id='body']/div[3]/nav/a[2]/div")
    end

    #verify that singinBox is shown
    def verfiySignBox
      #assert element_present?(:xpath, "//*[@id='multi-auth-inner']/section/div[4]/div[2]/div[2]")
    end

    #Click on sing event label
    def clickOnSignEventLabel
      el=@driver.find_element(:xpath,"//*[@id='body']/div[3]/nav/a[2]/div/span[2]")
      el.click
      sleep(5)
    end

    #click on sign with email link
    def clickOnSignWithEmail
      el= @driver.find_element(:xpath, "//*[@id='sign_in_user']/a/span")
      el.click
    end

    #verify email box is shown
    def  verifyEmailBox
      #assert element_present?(:id, "input-security-email")
    end

    #enter email address
    def enterEmailAddress
      el=@driver.find_element(:id,"input-security-email")
      el.send_keys "test360.001@gmail.com"
      sleep(5)
    end

    #Enter desired password
    def enterDesiredPassword
      el=@driver.find_element(:id,"input-security-password")
      el.send_keys "360logica"
      sleep(5)
    end

    #Enter full name of the user
    def enterFullName
      el=@driver.find_element(:id,"input-reg-name")
      el.send_keys "Test360FullName"
      sleep(5)
    end

    #Click on Registere link
    def clickOnRegister
      el=@driver.find_element(:xpath,"//*[@id='sign_in_user']/a/span")
      el.click
      sleep(5)
    end

end
