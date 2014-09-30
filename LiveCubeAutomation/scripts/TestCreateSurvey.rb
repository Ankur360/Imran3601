path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test verify survey" do


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
    CreateLog.new().LogStartExecution("execution started of Test Class Scenario test verify survey")
  end

  after(:each) do
    header = Header.new(@driver)
    header.logOut()
    @driver.quit
    CreateLog.new().LogEndExecution("execution end of Test Class Scenario test verify survey")
  end

  it "Login into the organizer app, create survey & verify survey created successfully" do

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

      #Verify that user created survey successfully
      editlivecubemeeting.createSurvey()
      successMsg= editlivecubemeeting.verifySurveyCreated()
      expect(successMsg).to include("Survey was successfully created.")


      rescue
      CreateLog.new().Log("open application url")
      raise
    end
  end
end
