path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "User can rate the session" do


  before(:each) do
    cc = ReadConfig.new()
    browserType = cc.getApplication('BrowseType')

    if browserType.eql?("ff")
      @driver = Selenium::WebDriver.for :firefox
    end
    @liveCubeOtherEmail=cc.getApplication('liveCubeOtherEmail')
    @liveCubeOtherPass=cc.getApplication('liveCubeOtherPass')
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
   # @driver.manage.window.maximize
    CreateLog.new().LogStartExecution("execution started of Test Class Rate the session")
  end

    after(:each) do
      lcHeader = LCubeHeader.new(@driver)
      lcHeader.liveCubeLogout()
      @driver.quit
      CreateLog.new().LogEndExecution("execution end of Test Rate the session")
   end

  it "Verify that user can Rate the session" do

    begin

      #open url
      loginEmail = LoginLiveCubeEmail.new(@driver)
      driverhelper=DriverHelper.new(@driver)
      url= driverhelper.readAttendeesUrl()
      @driver.get(url)


      #object creation
      conversion= ConversionPage.new(@driver)

      #Login to the application
      CreateLog.new().Log("open application url")
      #Login to the application
      logout=loginEmail.loginToApplication(@liveCubeOtherEmail,@liveCubeOtherPass)
      #verify that logout button is shown after logged into live cube application
      expect(logout).to eql(true)

      #verify that user is able to rate the session
      rateSession= conversion.rateTheSession(url)
      expect(rateSession).to eql(false)


      CreateLog.new().Log("login to the application")
    end
  end
end
