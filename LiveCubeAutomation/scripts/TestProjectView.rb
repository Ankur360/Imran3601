path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test verify projected view screen" do


  before(:each) do
    cc = ReadConfig.new()
    browserType = cc.getApplication('BrowseType')
    if browserType.eql?("ie")
      @driver = Selenium::WebDriver.for :ie
    end

    if browserType.eql?("ff")
      @driver = Selenium::WebDriver.for :firefox
    end
    @base_url = cc.getApplication('ORZRURL')
    @OrgEmail=cc.getApplication('OrgAdminEmail')
    @OrgPass=cc.getApplication('OrgAdminPass')
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.manage.window.maximize
    CreateLog.new().LogStartExecution("execution started of Test Class Scenario test verify projected view screen")
  end

  after(:each) do
    header = Header.new(@driver)
    header.logOut()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of Test Class Scenario test verify projected view screen")
  end

  it "Login into the organizer app and verify projected view screen" do

    begin
      #open url
      @driver.get(@base_url + "/")
      CreateLog.new().Log("open application url")

      #object creation
      login = Login.new(@driver)
      dashboard = OrganizerDashboard.new(@driver)
      editlivecubemeeting= EditLiveCubeMeeting.new(@driver)

      #login into Organizer Application
      login.loginToOrganizerApp(@OrgEmail,@OrgPass)
      #verify that user logged into application
      logout= login.logoutButtonDisplayed()
      expect(logout).to eql(true)


      #ClickOnMeeting
      meetingName= "Automation Meeting"
      dashboard.clickOnMeeting(meetingName)

      #Verify the project view
      #editlivecubemeeting.verifyProjectedViewScreen()

      messageBox, currentRankingBox, totalPointEarner= editlivecubemeeting.verifyProjectViewPage()

      expect(messageBox).to eql(true)
      expect(currentRankingBox).to eql(true)
      expect(totalPointEarner).to eql(true)

      rescue
      CreateLog.new().Log("open application url")
      raise
    end
  end
end
