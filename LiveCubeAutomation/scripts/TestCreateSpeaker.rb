path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test create speaker" do
	  
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
      @verification_errors =
      @driver.manage.window.maximize
      CreateLog.new().LogStartExecution("execution started of Test Class Scenario test create speaker")
    end
  
    after(:each) do
      header = Header.new(@driver)
      header.logOut()
      @driver.quit
      CreateLog.new().LogEndExecution("execution end of Test Class Scenario test create speaker")
    end
  
    it "verify that speaker created successfully" do

      #open url
      @driver.get(@base_url + "/")
      CreateLog.new().Log("open application url")
      #object creation
      login = Login.new(@driver)
      header = Header.new(@driver)
      dashboard = OrganizerDashboard.new(@driver)

      #login into Organizer Application
      login.loginToOrganizerApp(@OrgEmail,@OrgPass)
      #verify that user logged into application
      logout= login.logoutButtonDisplayed()
      expect(logout).to eql(true)

      #delete speaker if exist
      dashboard.deleteSpeaker()
      speakerName= "TestAutomationSpeaker"
      speakerExist= dashboard.verifySpeakerDeleted(speakerName)
      expect(speakerExist).to eql(false)
      #create speaker
      dashboard.createSpeaker()
      #verify that speaker created
      successMsg= dashboard.verifySpeakerCreated()
      expect(successMsg).to include("Speaker was successfully created.")
  end    
  
end
