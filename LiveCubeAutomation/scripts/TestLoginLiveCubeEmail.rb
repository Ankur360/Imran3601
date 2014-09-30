path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Login with Email Account" do

  before(:each) do
    cc = ReadConfig.new()
    browserType = cc.getApplication('BrowseType')
    if browserType.eql?("ff")
      @driver = Selenium::WebDriver.for :firefox
    end
    #@base_url = cc.getApplication('URLApp')
    @liveEmail=cc.getApplication('liveCubeEmail')
    @liveDesiredPass=cc.getApplication('liveCubePass')
    #@liveFullName=cc.getApplication('liveCubeFullName')
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.manage.window.maximize
    CreateLog.new().LogStartExecution("execution started of scenario login with email account")
  end

  after(:each) do
    lcHeader = LCubeHeader.new(@driver)
    lcHeader.liveCubeLogout()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of scenario login with email account")
  end

  it "Verify that user login into livecube application with email account" do

    begin
      #open url
      loginEmail = LoginLiveCubeEmail.new(@driver)
      driverhelper=DriverHelper.new(@driver)
      url= driverhelper.readAttendeesUrl()
      @driver.get(url)
      CreateLog.new().Log("open application url")
      #Login to the application
      logout= loginEmail.loginToApplication(@liveEmail,@liveDesiredPass)
      #verify that logout button is shown after logged into live cube application
      expect(logout).to eql(true)



    end
  end
 end
