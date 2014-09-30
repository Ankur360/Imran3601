path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test verify user activity " do

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
    CreateLog.new().LogStartExecution("execution started of Test Class scenarios verify user activity")
  end

  after(:each) do
    lcHeader = LCubeHeader.new(@driver)
    lcHeader.liveCubeLogout()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of Test Test Class scenarios verify user activity")

  end

  it "Verify that user activity" do

    begin
      #open url
      loginEmail = LoginLiveCubeEmail.new(@driver)
      driverhelper=DriverHelper.new(@driver)
      url= driverhelper.readAttendeesUrl()
      @driver.get(url)

      #object creation
      userActivity= UserActivityPage.new(@driver)

      #Login to the application
      CreateLog.new().Log("open application url")
      #Login to the application
      logout=loginEmail.loginToApplication(@liveEmail,@liveDesiredPass)
      #verify that logout button is shown after logged into live cube application
      expect(logout).to eql(true)

      #verify the user activities
      title, postMsg= userActivity.verifyActivity(url)
      #verify user activity title
      expect(title).to include("Activity")

      #verify post at activity
      expect(postMsg).to include("This is my fist post of automation")

      puts "Test verify user activity method completed successfully"

     CreateLog.new().Log("login to the application")
    end
  end
end
