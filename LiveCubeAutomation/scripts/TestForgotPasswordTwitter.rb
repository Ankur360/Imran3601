path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Test Scenario verify Forgot password functionality" do

  before(:each) do
    cc = ReadConfig.new()
    browserType = cc.getApplication('BrowseType')
    if browserType.eql?("ff")
      @driver = Selenium::WebDriver.for :firefox
    end
    #@base_url = cc.getApplication('URLApp')
    @liveTwitterEmail=cc.getApplication('liveCubeTwitterEmail')
    @liveTwitterPass=cc.getApplication('liveCubeTwitterPass')
    #@liveFullName=cc.getApplication('liveCubeFullName')
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.manage.window.maximize
    CreateLog.new().LogStartExecution("execution started of scenario Forgot password functionality")
  end

  after(:each) do
    #lcHeader = LCubeHeader.new(@driver)
    #lcHeader.liveCubeLogout()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of scenario Forgot password functionality")
  end

  it "Verify the Forgot password functionality" do

    begin
      #open url
      #login = LoginLiveCube.new(@driver)
      driverhelper=DriverHelper.new(@driver)
      url= driverhelper.readAttendeesUrl()
      @driver.get(url)
      CreateLog.new().Log("open application url")

      #object creation
      loginTwitter = LoginLiveCubeTwitter.new(@driver)

      #Verify Forgot password functionality
      confirmMsg= loginTwitter.VerifyForgotPassword(@liveTwitterEmail)

      #verify that confirmation message should be shown after reset the password
      expect(confirmMsg).to include("We've sent password reset instructions to your email address.")


    end
  end
end
