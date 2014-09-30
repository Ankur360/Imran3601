path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

require "rspec"
#require 'spec_helper'
RSpec::Support.require_rspec_support "caller_filter"
RSpec::Support.require_rspec_support "warnings"


class OrganizerDashboard < SupportHelper
  
    def initialize(driver)
    @driver = driver
    end
#############################Create Meeting Start#####################################################

    #Test create meeting
    def createMeeting()
      #Delete meeting if exist
      deleteMeetingIfExist("Automation Meeting")
      #Click on meeting
      clickOnMeetingButton()
      #Enter meeting name
      enterMeetingName()
      #Enter Host Name
      enterHostName()
      #click on messaging tab
      clickOnMessagingTab()
      checkTwitterCheckBox()
      checkEmailCheckBox()
      #Click on Date tab
      clickOnDatesTab()
      #Set the start date
      setStartDate("2014", "October", "10" )
      #Set the end date
      setEndDate("2014", "October", "17" )
      #click on features tab
      clickOnFeaturesTab()
      #check the check box of Attendees select team
      checkAttendeesTeamCheckBox()
      #Click on create meeting
      clickOnCreateMeeting()
      #verify meeting is created
      #verifyMeetingCreated()
      #get attendees url
      #getAttendeesURL()
      #write data into the file
      writeAttendeesUrl("Automation Meeting")
    end


    def clickOnFeaturesTab()
      el = @driver.find_element(:css, "span.fui-check")
      el.click
    end

     def checkAttendeesTeamCheckBox()
       el = @driver.find_element(:id, "meeting_attendee_selects_team")
       el.click
    end
     #click on meeting button
     def clickOnMeetingButton
      meeting = @driver.find_element(:xpath, "//span[contains(text(),'New Meeting')]")
      meeting.click
     end

    #Enter identity  details for ex: meeting name & URL Host
    def enterMeetingName()
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:id => "tab-c1").displayed? }
      @driver.find_element(:id, "meeting_name").clear
      meetingName= @driver.find_element(:id, "meeting_name")
      meetingName.send_keys "Automation Meeting"
    end

    #Enter the host name
    def enterHostName()
      @driver.find_element(:id, "meeting_subdomain").clear
      urlHostName= @driver.find_element(:id, "meeting_subdomain")
      urlHostName.send_keys "test"
    end

    #click on messaging tab
    def clickOnMessagingTab()
      el= @driver.find_element(:css, "span.fui-chat")
      el.click
    end

    #check twitter checkbox
    def checkTwitterCheckBox()
      el= @driver.find_element(:id, "meeting_strategy_ids_1")
      el.click
    end

    #check email checkbox
    def checkEmailCheckBox()
      el= @driver.find_element(:id, "meeting_strategy_ids_3")
      el.click
    end

    #Click on Dates tab
    def clickOnDatesTab()
      dates= @driver.find_element(:id, "tab5")
      dates=@driver.find_element(:xpath, "//*[@id='new_meeting']/div[2]/ul/li[5]/label")
      dates.click
    end

    #Select start date of the meeting
    def setStartDate(year, month, day)
      selectByID("meeting_start_date_1i", year)
      selectByID("meeting_start_date_2i", month)
      selectByID("meeting_start_date_3i", day)
    end

    #select end date of the meeting
    def setEndDate(year, month, day)
     selectByID("meeting_end_date_1i", year)
     selectByID("meeting_end_date_2i", month)
     selectByID("meeting_end_date_3i", day)
    end

    #Click on create meeting
    def clickOnCreateMeeting
    createMeeting= @driver.find_element(:name, "commit")
    createMeeting.click
    end

    #verify that meeting is created
    def verifyMeetingCreated()
     el = @driver.find_element(:id, "flash_notice")
     confirmationMessage= el.text
    #assert confirmationMessage.include? "Meeting was successfully created."
    #puts "after the expect"
    #expect(confirmationMessage).to equal("Meeting was successfully created.")
    #puts "Meeting end"
     confirmationMessage
    end

    def getAttendeesURL(meetingName)

        attendeesurl=""
        row = @driver.find_elements(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr").size
        for i in 1..row
          name=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[1]/a").text
          if name==meetingName
            attendeesurl= @driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[2]/a").text
          break
          end
        end
        attendeesurl
    end

  def writeAttendeesUrl(meetingName)
    url= getAttendeesURL(meetingName)
    append="https://"
    completeUrl= append.concat(url)
    File.open("attendeesUrl.txt", "w") do |file|
    file.puts completeUrl
    end

  end

   def deleteMeetingIfExist(meetingName)

       row =@driver.find_elements(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr").size
       for i in 1..row
         name=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[1]/a").text
         if name==meetingName
           @driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[5]/a[16]").click
           #delete the team
           acceptPopup()
           #Verify that team does not exist after deleting
           verifyTeamDeleted()
           break
         end
       end

   end

  def acceptPopup
    a = @driver.switch_to.alert
    if a.text == 'Are you sure you want to destroy this Meeting? All associated sessions and posts will be destroyed as well.'
      a.accept
    else
      a.dismiss
    end

  end
  def verifyTeamDeleted()
    el = @driver.find_element(:id, "flash_notice")
    confirmationMessage= el.text
    #assert confirmationMessage.include? "Meeting was deleted successfully."
  end

##############################Create Meeting End#####################################################


#############################Create Speaker Start#####################################################

  #Create speaker
   def createSpeaker()
      sleep(5)
      #Click on new speaker button
      clickOnNewSpeaker()
      #Enter all the speaker details
      enterSpeakerDetails("TestAutomationSpeaker")
      #Click on create speaker
      clickCreateSpeaker()
      #Verify that speaker created
      #verifySpeakerCreated()
   end

  def deleteSpeaker()
    #Click on speaker
    clickOnSpeaker()
    sleep(5)
    deleteSpeakerIfExist("TestAutomationSpeaker")

  end

    #Click on speaker
    def clickOnSpeaker
      #speakerButton= @driver.find_element(:xpath, "//a[@href='/orgs/8/speakers']")
      speakerButton= @driver.find_element(:xpath, "//a[@class='btn btn-primary btn-float-right bg-ocean hover-to-grayCold']/span")
      speakerButton.click
    end

    #Click on new Speaker
    def clickOnNewSpeaker
      newSpeaker= @driver.find_element(:css, "span.fui-plus")
      newSpeaker.click
    end

    #Enter the speaker details speaker name, title and company
    def enterSpeakerDetails(sName)
      speakerName= @driver.find_element(:id, "speaker_name")
      speakerName.clear
      speakerName.send_keys sName
      speakerTitle= @driver.find_element(:id, "speaker_title")
      speakerTitle.clear
      speakerTitle.send_keys "TestAutomationTitle"
      speakerComp= @driver.find_element(:id, "speaker_company")
      speakerComp.clear
      speakerComp.send_keys "Test360"
    end

    #Click on cretae speaker
    def clickCreateSpeaker
      createSpeaker= @driver.find_element(:name, "commit")
      createSpeaker.click
    end

    #After creating the speaker verify the confirmation message
    def verifySpeakerCreated()
    el= @driver.find_element(:id, "flash_notice")
    confirmMsg= el.text

    #assert_equal confirmMsg, "Speaker was successfully created."
    confirmMsg
    end

  def deleteSpeakerIfExist(speakerName)

    row =@driver.find_elements(:xpath, " //*[@id='app']/div[2]/div/table/tbody/tr").size
    for i in 2..row
      name=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div/table/tbody/tr["+i.to_s+"]/td[2]/a").text
      if name==speakerName
         @driver.find_element(:xpath, "//*[@id='app']/div[2]/div/table/tbody/tr["+i.to_s+"]/td[7]/a[2]/i").click
        #delete the team
        acceptDeleteSpeakerPopup()
         sleep(6)
        #Verify that team does not exist after deleting
        break
       end
    end
  end

  def acceptDeleteSpeakerPopup
    a = @driver.switch_to.alert
    if a.text == 'Are you sure?'
      a.accept
    else
      a.dismiss
    end

  end
  def verifySpeakerDeleted(speakerName)
    speaker= speakerExist(speakerName)
    #assert_equal speaker, false
    speaker
  end

  def speakerExist(speakerName)
    row =@driver.find_elements(:xpath, " //*[@id='app']/div[2]/div/table/tbody/tr").size
    status= false
    for i in 2..row
      name=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div/table/tbody/tr["+i.to_s+"]/td[2]/a").text
      if name==speakerName
        status=true
        break
      end
    end
    status
  end

#############################Create Speaker End#####################################################


#############################Create Session Start#####################################################

    #Create the session
    def createSession(meetingName)
      clickOnMeeting(meetingName)
      clickOnSession()
      clickOnNewSession()
      enterSessionDetails()
      clickOnSpeakerTab()
      selectSpeaker("TestAutomationSpeaker")
      clickOnSaveSession()
      #verifyEventCreated()
    end

    #Search the meeting and then click on the specified meeting
    def clickOnMeeting(meetingName)
     row = @driver.find_elements(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr").size
       for i in 1..row
        name=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[1]/a").text
        if name==meetingName
         @driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[1]/a").click
         wait = Selenium::WebDriver::Wait.new(:timeout => 10)
         wait.until { @driver.find_element(:class => "meeting-buttons").displayed? }
         break
        end
      end
    end

    #click on session button
    def clickOnSession
      el=@driver.find_element(:class, "fui-calendar")
      el.click
    end

    #Click on New Session Button
    def clickOnNewSession
      el=@driver.find_element(:class, "fui-plus")
      el.click
    end

    #Enter the session details
    def enterSessionDetails()
      #Enter session Name
      sessionName= @driver.find_element(:id, "event_session_name")
      sessionName.clear
      sessionName.send_keys "Automation Session"
      #Enter session description
      sessionDes= @driver.find_element(:id, "event_description")
      sessionDes.clear
      sessionDes.send_keys "Test description"
      #Select section type
      selectByID("event_event_type_id", "Q & A")
      #Enter session date
      enterStartDate()
      sleep(5)
      enterEndDate()
      sleep(5)

    end

    #Enter session start date
    def enterStartDate()

      #Enter current date
      el= @driver.find_element(:id, "event_start_date_time")
      currentDate= el.attribute("value")

      el1= @driver.find_element(:id, "event_start_date_time")
      el1.send_keys currentDate
      currentDate
    end

    #Enter session end date
    def enterEndDate()

      endDate= increaseDate
      el= @driver.find_element(:id, "event_end_date_time")
      el.send_keys endDate
    end

    #Enter stage
    def enterRoomLocation
      el= @driver.find_element(:id, "event_location_simple")
      el.send_keys "Stage"
    end

    #Enter on speaker tab and wait for the page load
    def clickOnSpeakerTab
      el= @driver.find_element(:xpath, "//*[@id='new_event']/div[2]/ul/li[2]/label")
      el.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:xpath => "//a[contains(text(),'Speaker')]").displayed? }

    end

    #Click on speaker drop down and select a speaker
    def selectSpeaker(speakerName)
      el= @driver.find_element(:css, "a.btn")
      el.click
     speaker_select = @driver.find_element(:xpath, "//select[contains(@id,'event_speaker_slots_attributes')]")
      options=speaker_select.find_elements(:tag_name=>"option")
      options.each do |g|
        if g.text == speakerName
          g.click
          break
        end
      end
      end

    def clickOnSaveSession
      el= @driver.find_element(:name, "commit")
      el.click
    end

    #Verify that event <Session> created successfully and confirmation should be shown"
    def verifyEventCreated
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:id => "flash_notice").displayed? }
      confMessage = @driver.find_element(:id, "flash_notice").text
      #assert_equal confMessage, "Event was successfully created.", "Confirmation message should shown after creating session"
      confMessage
    end

  def increaseDate()
    #Enter current date
    t= enterStartDate

    date= t.split("-")
    a = Array.new(date)
    b=a[2]
    c= b.split()
    d= c[0]
    z= d.to_i
    k=z+1
    p= k.to_s
    dd= a[0]+"-"+a[1]+ "-"+p+" "+c[1]+" "+c[2]
    puts dd==t
    dd
  end
  #############################Create Session End#####################################################

end


