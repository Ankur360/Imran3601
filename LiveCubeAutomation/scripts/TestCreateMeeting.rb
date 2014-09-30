path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("Scripts").first
require path+"/driver_helper.rb"
require "json"
require "selenium-webdriver"
require "rspec"

describe "Scenario test create meeting" do
	  

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
      CreateLog.new().LogStartExecution("execution started of Test Class Scenario test create meeting")
    end
  
    after(:each) do
      header = Header.new(@driver)
      header.logOut()
      @driver.quit
      CreateLog.new().LogEndExecution("execution end of Test Class create meeting")
    end
  
    it "Login into the organizer app and create meeting" do
  	
    begin
      #open url
      @driver.get(@base_url + "/")
      CreateLog.new().Log("open application url")

      #object creation
      login = Login.new(@driver)
      dashboard = OrganizerDashboard.new(@driver)


      #login into Organizer Application
      login.loginToOrganizerApp(@OrgEmail,@OrgPass)
      #verify that user logged into application
      logout= login.logoutButtonDisplayed()
      expect(logout).to eql(true)

      dashboard.createMeeting()
      #verify meeting created successfuly
      message= dashboard.verifyMeetingCreated()
      expect(message).to include("Meeting was successfully created.")

      puts "Test Meeting creation completed"

    rescue
      CreateLog.new().Log("open application url")
    raise
    end
	end
end
