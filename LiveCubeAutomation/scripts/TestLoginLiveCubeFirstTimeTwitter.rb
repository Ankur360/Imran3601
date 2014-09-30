path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test login with twitter account at very first time" do

  before(:each) do
    cc = ReadConfig.new()
    browserType = cc.getApplication('BrowseType')
    if browserType.eql?("ff")
      @driver = Selenium::WebDriver.for :firefox
    end
    #@base_url = cc.getApplication('URLApp')
    @liveTwitterEmail=cc.getApplication('liveCubeTwitterEmail')
    @liveTwitterPass=cc.getApplication('liveCubeTwitterPass')
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.manage.window.maximize
    CreateLog.new().LogStartExecution("execution started of scenario login with twitter account at very first time")
  end

  after(:each) do
    lcHeader = LCubeHeader.new(@driver)
    lcHeader.liveCubeLogout()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of scenario login with twitter account at very first time")
  end

  it "Verify that user login into the application with twitter account at very first time" do

    begin
      #open url
      driverhelper=DriverHelper.new(@driver)
      url= driverhelper.readAttendeesUrl()
      @driver.get(url)
      CreateLog.new().Log("open application url")

      #object creation
      loginTwitter = LoginLiveCubeFirstTimeTwitter.new(@driver)
      #livecubelogout= LCubeHeader.new(@driver)

      #Login to the application and verify that team is displayed & user logged into LiveCube Application
      team, logout= loginTwitter.loginToApplication(@liveTwitterEmail,@liveTwitterPass)

      #verify that team should be displayed
      expect(team).to include("Automation Team")

      #verify that user logged into LiveCube application
      expect(logout).to eql(true)

    end
  end
end
