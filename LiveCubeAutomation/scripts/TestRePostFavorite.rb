path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "User can repost and favorite" do


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
    CreateLog.new().LogStartExecution("execution started of Test Class Repost and favorite")
  end

    after(:each) do
      lcHeader = LCubeHeader.new(@driver)
      lcHeader.liveCubeLogout()
      @driver.quit
      CreateLog.new().LogEndExecution("execution end of Test Repost and Favorite")

  end

  it "Verify that user can Repost and Favorite " do

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
      logout=loginEmail.loginToApplicationWithOtherUser(@liveCubeOtherEmail,@liveCubeOtherPass)
      #verify that logout button is shown after logged into live cube application
      expect(logout).to eql(true)

      #provide repost with different user
      repost= conversion.provideRePost()
      expect(repost).to include("Reposted")


      #Do favourite with different user
      favourite= conversion.provideFavorites()
      expect(favourite).to include("Favorited")

      CreateLog.new().Log("login to the application")
    end
  end
end
