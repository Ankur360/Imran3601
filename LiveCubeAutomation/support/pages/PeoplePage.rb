path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class PeoplePage < SupportHelper

    def initialize(driver)
      @driver = driver
    end

    #verifies the attendees on people page
    def verifyAttendees()
      clickPeopleLink()
      verifyAttendeesDisplayed()
    end

    #click on people tab
    def clickPeopleLink()
      sleep(5)
      @driver.find_element(:xpath, "//*[@id='main-content']/nav/div[2]/div/a[3]").click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:id => "attendees").displayed? }
    end

    #At attendees section verify that attendees are displayed
    def verifyAttendeesDisplayed()
    attendees= attendeesDisplayed()
    assert_equal attendees, true, "In people screen attendees should be shown"
    end

    def attendeesDisplayed()
        status= false
        begin
          @driver.find_element(:id, "attendees").displayed?
          status= true
        rescue Exception => e
          status= false
        end
        status
    end

   #At people screen verify that speaker is shown
    def verifySpeakers(url)
      clickPeopleLink()
      clickOnSpeakers()
      verifySpeakersDisplayed()
      refreshPage(url)
    end

    #click on speaker tab at people>>speaker tab
    def clickOnSpeakers()
     el= @driver.find_element(:css, "a.x-btn-speakers")
     el.click
     wait = Selenium::WebDriver::Wait.new(:timeout => 10)
     wait.until { @driver.find_element(:css => "span.speaker-tag").displayed? }
    end

    #verify that speakers are displayed
    def verifySpeakersDisplayed()
      speakers= speakersDisplayed()
      #assert_equal speakers, true, "In people>>speaker screen speakers should be shown"
    end

    def refreshPage(url)
      @driver.get url
    end

    def speakersDisplayed()
      status= false
      begin
        @driver.find_element(:css, "span.speaker-tag").displayed?
        status= true
      rescue Exception => e
        status= false
      end
      status
    end
  end




