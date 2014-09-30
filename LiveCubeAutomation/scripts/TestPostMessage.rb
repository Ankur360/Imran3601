path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "User can provide the post message " do


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
    CreateLog.new().LogStartExecution("execution started of Test Class user can add post the message")
  end

    after(:each) do
      lcHeader = LCubeHeader.new(@driver)
      lcHeader.liveCubeLogout()
      @driver.quit
      CreateLog.new().LogEndExecution("execution end of Test post message")

  end

  it "Verify that user able to post the message" do

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
      logout=loginEmail.loginToApplication(@liveEmail,@liveDesiredPass)
      #verify that logout button is shown after logged into live cube application
      expect(logout).to eql(true)

      #Verify that user able to do post
      postMessage= "This is my fist post of automation"
      postMsg= conversion.providePost(url,postMessage)

      expect(postMsg).to include("This is my fist post of automation")
      CreateLog.new().Log("login to the application")
    end
  end
end
