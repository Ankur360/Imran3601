path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class EditLiveCubeMeeting < SupportHelper

    def initialize(driver)
      @driver = driver
    end

    def verifyProjectedViewScreen()
      verifyProjectViewPage()
    end

    #click on projected view button and move to next window
    def verifyProjectViewPage()
     #click on project view and move to next window
      main_window = @driver.window_handle

      @driver.find_element(:link, 'Projected View').click
      windows = @driver.window_handles
      windows.each do |window|
         if main_window != window
          @new_window = window
         end
      end


      @driver.switch_to.window(@new_window)

      #verify that message box is displayed at project view screen
      el= @driver.find_element(:css, "div.igi")
      messageBox= el.displayed?
      #assert_equal messageBox, true, "In Projected view page message box should be shown"

      #verify that current team ranking box is displayed at project view screen
      el2= @driver.find_element(:css, "li.ranking")
      currentRankingBox= el2.displayed?
      #assert_equal currentRankingBox, true, "In Projected view page Current Team Rankings box should be shown"

      #verify that total point earner box is displayed at project view screen
      el3= @driver.find_element(:xpath, "//*[@id='leaderboards']/div[4]/div/ul/li/h5")
      totalPointEarner= el3.displayed?
      #assert_equal totalPointEarner, true, "In Projected view page total point earner box should be shown"

      #switch back into main window
      @driver.switch_to.window(main_window)

      return [messageBox, currentRankingBox, totalPointEarner]
    end


    def createSurvey()
      clickOnSurveyLink()
      clickOnNewSurvey()
      enterSurveyDetails()
      provideQuestion()
      selectQuesTime()
      clickOnAnswer()
      enterAnswers()
      clickOnCreateSurvey()
      #verifySurveyCreated()
    end

    #click on survey link
    def clickOnSurveyLink()
      @driver.find_element(:link, "Surveys").click
    end

    #click on new survey link
    def clickOnNewSurvey()
      @driver.find_element(:link, "New Survey").click
    end

    #Enter survey details
    def enterSurveyDetails()
      #Enter survey title
      el= @driver.find_element(:id, "survey_title")
      el.clear
      el.send_keys "autoSurvey"

      #Enter survey notes
      el2= @driver.find_element(:id, "survey_cue_notes")
      el2.clear
      el2.send_keys "autoNotes"
    end

    #select survey question
    def provideQuestion()
     el= @driver.find_element(:css, "a.btn")
     el.click
     el2= @driver.find_element(:xpath, "//textarea[contains(@id,'survey_survey_questions_attributes')]")
     el2.send_keys "How we will perform the automation testing"

    end

    #select survey question time
    def selectQuesTime()
      speaker_select = @driver.find_element(:xpath, "//select[contains(@id,'survey_survey_questions_attributes')]")
      options=speaker_select.find_elements(:tag_name=>"option")
      options.each do |g|
        if g.text == "20"
          g.click
          break
        end
      end
    end

    #click on answer link
    def clickOnAnswer()
      el= @driver.find_element(:link, "Answers")
      el.click
    end


    #Enter the answers
    def enterAnswers()
     #Provide first answer
     ans1=@driver.find_element(:xpath, "//div[@class='control-group text optional survey_survey_questions_content']/fieldset[1]/div/div/input[contains(@id,'survey_survey_questions_attributes')]")
     ans1.send_keys "Answer1"
     #Provide second answer
     ans2=@driver.find_element(:xpath, "//div[@class='control-group text optional survey_survey_questions_content']/fieldset[2]/div/div/input[contains(@id,'survey_survey_questions_attributes')]")
     ans2.send_keys "Answer2"
     #Provide third answer
     ans3=@driver.find_element(:xpath, "//div[@class='control-group text optional survey_survey_questions_content']/fieldset[3]/div/div/input[contains(@id,'survey_survey_questions_attributes')]")
     ans3.send_keys "Answer3"
    end

    #click on create survey button
    def clickOnCreateSurvey()
      el= @driver.find_element(:name, "commit")
      el.click
    end

    #verify that survey created successfully
    def verifySurveyCreated()
      el= @driver.find_element(:id, "flash_notice").text
      #assert_equal el, "Survey was successfully created.", "Survey should be created"
      el

    end

#############Test create the Team#########################################################

#Test create and delete the team
  def testCreateTeam()
    sleep(5)
    clickOnNewTeamLink()
    enterTeamDetails()
    sleep(5)
    uplaodTeamEmblem()
    clickOnSaveTeam()

  end


 #delete the team and verify it's deleted
  def deleteTeamIfExist(teamName)
    clickOnTeam()
    deleteTeam(teamName)
  end



  #click on team link
  def clickOnTeam()
    el=@driver.find_element(:link, "Teams")
    el.click
  end

  # delete the team
  def deleteTeam(teamName)

    row = @driver.find_elements(:xpath, "//*[@id='teams-index']/div/table/tbody/tr").size
    for i in 1..row
      name=@driver.find_element(:xpath, "//*[@id='teams-index']/div/table/tbody/tr["+i.to_s+"]/td[3]").text
      if name==teamName
        @driver.find_element(:xpath, "//*[@id='teams-index']/div/table/tbody/tr["+i.to_s+"]/td[6]/a[2]/i").click
        #delete the team
        acceptPopup()
        #Verify that team does not exist after deleting
        #verifyTeamNotExist(teamName)
        break
      end
    end

  end

  # verify that after deleting the team, team should should not be shown
  def verifyTeamNotExist(teamName)
    team= teamExist(teamName)
    #assert_equal team, false, "After deleting, team should not be shown"
    team
  end


  #Check that team exist or not
  def teamExist(teamName)
    row = @driver.find_elements(:xpath, "//*[@id='teams-index']/div/table/tbody/tr").size

    status= false
    for i in 1..row
      name=@driver.find_element(:xpath, "//*[@id='teams-index']/div/table/tbody/tr["+i.to_s+"]/td[3]").text
      if name==teamName
        status=true
        break
      end
    end
    status
  end

  #Delete the team by accepting or dismissing
  def acceptPopup
    a = @driver.switch_to.alert
    if a.text == 'Are you sure?'
      a.accept
    else
      a.dismiss
    end

  end


  #Click on new team link
  def clickOnNewTeamLink
    el= @driver.find_element(:link, "New Team")
    el.click
  end

  #enter team details team name, color code
  def enterTeamDetails()
    teamName= @driver.find_element(:id, "team_name")
    teamName.clear
    teamName.send_keys "Automation Team"

    teamColor= @driver.find_element(:id, "team_color")
    teamColor.clear
    teamColor.send_keys "FB923B"
  end

  #upload the team emblem image
  def uplaodTeamEmblem()
    upload=  @driver.find_element(:xpath, "//span[@class='fui-cloud-upload dIB vaT']")
    upload.send_keys "C:\\Users\Public\\Pictures\\Sample Pictures\\Desert.jpg"
  end

  #click on save team button
  def clickOnSaveTeam()
    saveTeam= @driver.find_element(:name, "commit")
    saveTeam.click
  end

  #verify team created successfully
  def verifyTeamCreated()
    el=  @driver.find_element(:id, "flash_notice")
    successMsg= el.text
    #assert_equal successMsg, "Team was successfully created.", "Team success message should be shown"
    successMsg

  end
#############Test create and delete the Team End######################################################


#############Create prize and verify that prize created successfully###############################

   def createPrize()
     sleep(3)
     clickOnNewPrize()
     enterPrizeDetails()
     selectAward()
     #uploadPrizeImage()  currently this functionality is not working
     selectCriteria()
     enterCriteriaDesc()
     selectScope()
     #eligibilityDate() currently this functionality is not working
     clickOnCreatePrize()
     #verifyPrizeCreated("Automation Prize Title")
   end



  def deletePrizeIfExist()
    clickOnPrize()
    deletePrize("Automation Prize Title")
  end

   #click on prize link
   def clickOnPrize()
     el= @driver.find_element(:link, "Prizes")
     el.click
   end

    #click on new prize link
    def clickOnNewPrize()
      el= @driver.find_element(:link, "New Prize")
      el.click
    end

    #enter prize details
    def enterPrizeDetails()
      prizeTitle= @driver.find_element(:id, "prize_name")
      prizeTitle.clear
      prizeTitle.send_keys "Automation Prize Title"
    end

    #select award to drop down
    def selectAward()
      selectByID("prize_award_to", "Top")
      el= @driver.find_element(:id, "prize_award_to_count")
      el.clear
      el.send_keys "10"
    end

    #upload prize image
    def uploadPrizeImage()
    el= @driver.find_element(:css, "span.fui-cloud-upload")
    el.click
    el.send_keys "complete path location"
    end

    #select prize criteria
    def selectCriteria()
      selectByID("prize_prize_criteria_type_id", "Reposts Earned")
    end

    #enter criteria description
    def enterCriteriaDesc()
      el= @driver.find_element(:id, "prize_criteria")
      el.clear
      el.send_keys "Auto Desc"
    end

    #select scope drop down
    def selectScope()
      selectByID("prize_prizeable_type", "Entire Meeting")
    end

    #Provide prize eligibility date
    def eligibilityDate

    end

    #click on create prize button
    def clickOnCreatePrize()
      el= @driver.find_element(:name, "commit")
      el.click
    end

    #verify that prize is created and exist on prize screen
    def verifyPrizeCreated(prizeName)
      prize= prizeNameExist(prizeName)
      #assert_equal prize, true, "Created prize should be shown in prize list"
      prize
    end


    def deletePrize(prizeName)
      result= prizeNameExist(prizeName)
      if result
        row = @driver.find_elements(:xpath, "//tbody[@id='prizes']/tr").size
          for i in 1..row
            #@driver.find_element(:xpath, "//*[@id='prize_404']/td["+i.to_s+"]").text
            name=@driver.find_element(:xpath, "//tbody[@id='prizes']/tr["+i.to_s+"]/td[2]").text
            if name==prizeName
              @driver.find_element(:xpath, "//tbody[@id='prizes']/tr["+i.to_s+"]/td[7]/a[3]/i").click
              sleep(5)
              acceptDeletePopup()
              sleep(5)
              break
            end
          end
      end
    end


    #Check prize name exist or not
    def prizeNameExist(prizeName)
      status= false
      row = @driver.find_elements(:xpath, "//tbody[@id='prizes']/tr").size
      for i in 1..row
        #@driver.find_element(:xpath, "//*[@id='prize_404']/td["+i.to_s+"]").text
        name=@driver.find_element(:xpath, "//tbody[@id='prizes']/tr["+i.to_s+"]/td[2]").text
        if name==prizeName
          status= true
          break
        end
      end
      status
    end


    def acceptDeletePopup()
      a = @driver.switch_to.alert
      if a.text == 'Are you sure?'
        a.accept
      else
        a.dismiss
      end
    end

############# Create NewIceBreaker ##########################################################################

#Test create NewIceBreaker
    def createNewIceBreaker()
      clickOnIceBreaker()
      clickOnNewIceBreaker()
      selectType()
      selectDuration()
      clickOnCreateIceBreaker()
      #verifyIceBreakerCreated()
      sleep (5)
      #clickOnProjectedView("60s")
    end

    #click on icebreaker
    def clickOnIceBreaker()
      el= @driver.find_element(:link, "Icebreakers")
      el.click
    end

    #click on new icebreaker
    def clickOnNewIceBreaker()
      el= @driver.find_element(:link, "New Icebreaker")
      el.click
    end

    #select space type
    def selectType()
      selectByID("icebreaker_icebreaker_type_id", "Space Race")
    end

    #select space duration
    def selectDuration()
      selectByID("icebreaker_duration_seconds", "60s")
    end

    #click on create icebreaker
    def clickOnCreateIceBreaker()
      el= @driver.find_element(:name, "commit")
      el.click
    end

    #verify that created iceBreaker exist on list
    def verifyIceBreakerCreated()
      el=@driver.find_element(:id, "flash_notice").text
      #assert_equal el, "Icebreaker was successfully created.", "Icebreaker should be created"
      el

    end

    #click on projected view and verify the projected view screen elements
    def clickOnProjectedView(duration)
      row = @driver.find_elements(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr").size
      for i in 2..row
        durationTime=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[3]").text
        if duration==durationTime
          @driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[6]/a[2]/span").click
          #Move to projected view screen and verify the elements on this page
          verifyProjectViewScreen()
          break
        end
      end

    end

    #click on deploy now link verify and perform the activities
    def clickOnDeployNow(duration)
      row = @driver.find_elements(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr").size
      for i in 1..row
        durationTime=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[3]").text
        if duration==durationTime
          @driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[6]/a[1]/i").click
          break
        end
      end
    end


    def isElementVisible(element, timeout)
      status=false
      for i in 1..timeout
        if @driver.find_element(:xpath, "element").visible?
          status=true
          break
        end
        sleep(1)

      end
      status
    end


    #Check that team exist or not
    def iceBreakerExist(duration)
      row = @driver.find_elements(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr").size

      status= false
      for i in 1..row
        duration=@driver.find_element(:xpath, "//*[@id='app']/div[2]/div[3]/table/tbody/tr["+i.to_s+"]/td[3]").text
        if name==teamName
          status=true
          break
        end
      end
      status
    end

    def verifyProjectViewScreen()

      #click on project view and move to next window
      main_window = @driver.window_handle
      windows = @driver.window_handles
      windows.each do |window|
        if main_window != window
          @new_window = window
        end
      end

      @driver.switch_to.window(@new_window)

      #verify that message box is displayed at project view screen
      el= @driver.find_element(:css, "div.igi")
      messageBox= el.displayed?
      #assert_equal messageBox, true, "In Projected view page message box should be shown"

      #verify that current team ranking box is displayed at project view screen
      el2= @driver.find_element(:css, "li.ranking")
      currentRankingBox= el2.displayed?
      #assert_equal currentRankingBox, true, "In Projected view page Current Team Rankings box should be shown"

      #switch back into main window
      @driver.switch_to.window(main_window)
    end
end