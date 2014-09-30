path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test more>>information page " do


  before(:each) do
    cc = ReadConfig.new()
    browserType = cc.getApplication('BrowseType')

    if browserType.eql?("ff")
      @driver = Selenium::WebDriver.for :firefox
    end
    @liveEmail=cc.getApplication('liveCubeEmail')
    @liveDesiredPass=cc.getApplication('liveCubePass')
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    # @driver.manage.window.maximize
    CreateLog.new().LogStartExecution("execution started of Test Class scenarios verify more>>information page")
  end

  after(:each) do
    lcHeader = LCubeHeader.new(@driver)
    lcHeader.liveCubeLogout()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of Test Test Class scenarios verify more>>information page")

  end

  it "Verify that more>>information page" do

    begin

      #open url
      loginEmail = LoginLiveCubeEmail.new(@driver)
      driverhelper=DriverHelper.new(@driver)
      url= driverhelper.readAttendeesUrl()
      @driver.get(url)

      #object creation
      morePage= MorePage.new(@driver)

      #Login to the application
      CreateLog.new().Log("open application url")
      #Login to the application
      logout=loginEmail.loginToApplication(@liveEmail,@liveDesiredPass)
      #verify that logout button is shown after logged into live cube application
      expect(logout).to eql(true)

      #verify the information page
      meetingExist= morePage.verifyInformationScreen()

      expect(meetingExist).to include("Automation Meeting")

      puts "Test verify information method completed successfully"
      CreateLog.new().Log("login to the application")
    end
  end
end
