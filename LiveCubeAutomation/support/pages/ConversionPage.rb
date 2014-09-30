path = File.expand_path(File.dirname(File.dirname(__FILE__))).split("pages").first
require path+"/support_helper.rb"

class ConversionPage < SupportHelper

      def initialize(driver)
        @driver = driver
      end

      #Verify that user able to do post and delete the post
      def providePost(url,postMessage)
        clickOnSchedule()
        clickJoinSession()
        #enterPost()
        enterPostMessage(postMessage)
        #uploadPhoto()

        clickOnPost()
        #clickOnPostAndVerifySuccessMsg()
        post= verifyPostDisplayed(url)
      end

      #click on schedule tab
      def clickOnSchedule()
        el= @driver.find_element(:xpath, "//span[contains(text(),'Schedule')]")
        el.click
        wait = Selenium::WebDriver::Wait.new(:timeout => 10)
        wait.until { @driver.find_element(:xpath => "//span[contains(text(),'Save')]").displayed? }
      end

      #click JoinSession Link
      def clickJoinSession
        el= @driver.find_element(:xpath, "//span[contains(text(),'Join Conversation')]")
        el.click
        sleep(5)
      end

      def uploadPhoto()
        el= @driver.find_element(:css, "div.photo-btn-c")
        el.send_keys ("E://Project//LiveCube//LiveCubeAutomation//AutomationImage.png")
        sleep(10)
      end

     #Enter the post
      def enterPost()
        el= @driver.find_element(:xpath, "//*[@id='session']/section[2]/div/div[1]/div/div[2]/textarea")
        el.clear
        el.send_keys "This is my fist post of automation"
      end

      #Enter the post
      def enterPostMessage(postMessage)
        el= @driver.find_element(:xpath, "//textarea[@placeholder='Share a Thought or Question']")
        #el.clear
        el.send_keys postMessage
      end

      #click on post and verify the new window success message at very first time when user try to post
      def clickOnPostAndVerifySuccessMsg()
        #click on project view and move to next window
        main_window = @driver.window_handle
        postLink= @driver.find_element(:link, "Post")
        postLink.click
        windows = @driver.window_handles
        windows.each do |window|
          if main_window != window
            @new_window = window
          end
        end
       @driver.switch_to.window(@new_window)

        #verify the success message
        el= @driver.find_element(:xpath, "//div[@class='inner']/h1[text()='Challenge Complete!']")
        success= el.text
        #assert success.include? "Challenge Complete"

        #enter phone number
        el= @driver.find_element(:id, "notification-phone")
        el.send_keys "98788767"
        #click on submit button
        el= @driver.find_element(:xpath, "submit button= //input[@type='submit']")
        el.click
        #switch back into main window
        @driver.switch_to.window(main_window)
      end

      def clickOnPost()
        postLink= @driver.find_element(:link, "Post")
        postLink.click
      end

      #verify posted message is shown on conversion screen
      def verifyPostDisplayed(url)
        @driver.navigate.refresh
        @driver.get url
        sleep(5)
        wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
        element = wait.until { @driver.find_element(:id => "posts") }

        #el= @driver.find_element(:xpath, "//*[@id='posts']/li[2]/div[1]/div[2]/div[2]/p")
        el= @driver.find_element(:xpath, "//*[@id='posts']/li/div[1]/div[2]/div/p")

        postMsg= el.text
        #assert postMsg.include? "This is my fist post of automation"
        postMsg
      end

      def verifyCommentPosted()
        p=getSize
        r=p-1
        comment= @driver.find_elements(:xpath, "//*[@id='posts']/li["+r.to_s+"]/div[1]/div[2]/div[2]/p").text
      end

      #delete the post
      def deletePost()
        #Refresh the page
        @driver.navigate.refresh
        @driver.get "https://india.livecubestaging.com"
        wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
        element = wait.until { @driver.find_element(:id => "posts") }

        #click on more link
        @driver.find_element(:xpath, "//*[@id='posts']/li[2]/div[2]/a").click
        sleep(5)
        #click on remove link at post
        @driver.find_element(:xpath, "//*[@id='posts']/li[2]/div[3]/div/a[4]/span[1]").click

        #click on 'Are you sure' delete this post
        sleep(5)
        el3= @driver.find_element(:link, "Yes, Delete this Post")
        el3.click

        #verify that commented post deleted and it is not shown
        commentBox=RemovedPostDisplayed()
       # assert_equal commentBox,false, "omment box should not be shown"
     end

      #check that removed post is displayed or not
      def RemovedPostDisplayed()
        status= false
        begin
          @driver.find_element(:xpath, "//*[@id='posts']/li[2]/div[1]/div[2]/div[2]/p").displayed?
          status= true
        rescue Exception => e
          status= false
        end
        status
      end

      #get the count of row size
      def getSize
        row = @driver.find_elements(:xpath, "//*[@id='posts']/li").size
        row
      end

###################################Test Repost and Favourite###############################

    def provideRePost()
      sleep(6)
      clickonRepostsLink()
      sleep(6)
      #clickOnRepostAndVerifySuccessMsg()
      repost= verifyReposted()
    end

    def clickOnRepostAndVerifySuccessMsg()
      #click on project view and move to next window
      main_window = @driver.window_handle
      clickonRepostedLink()
      windows = @driver.window_handles
      windows.each do |window|
        if main_window != window
          @new_window = window
        end
      end
      @driver.switch_to.window(@new_window)

      #verify the success message
      el= @driver.find_element(:xpath, "//div[@class='inner']/h1[text()='Challenge Complete!']")
      success= el.text
      #assert success.include? "Challenge Complete"

      #enter phone number
      el= @driver.find_element(:id, "notification-phone")
      el.send_keys "98788767"
      #click on submit button
      el= @driver.find_element(:xpath, "submit button= //input[@type='submit']")
      el.click
      #switch back into main window
      @driver.switch_to.window(main_window)
    end

    #verfy that text is changed after repost
    def verifyReposted()
      el= @driver.find_element(:xpath, "//span[text()='reposted']")
      re= el.text
     # assert re.include? "Reposted"
      re

    end

    #Click on repost link
    def clickonRepostsLink()
          el= @driver.find_element(:xpath, "//span[text()='repost']")
          el.click
    end

    #Verify that user can do a post favorite
    def provideFavorites()
      sleep(6)
      clickonFavoriteLink()
      sleep(6)
     fav= verifyFavorited
      sleep(6)
      verifyReposted()

    end

    #Click on favourite link
    def clickonFavoriteLink()
      el= @driver.find_element(:xpath, "//span[text()='favorite']")
      el.click

    end

    #verify that favourite text changed
    def verifyFavorited()
      el= @driver.find_element(:xpath, "//span[text()='favorited']")
      fv= el.text
      #assert re.include? "Favorited"
      fv
    end
############################# Test Rate the session #######################################

    #verify that user can rate the session
    def rateTheSession(url)
      clickOnSchedule()
      clickOnViewPastCon()
      clickRateSession()
      giveRating(url)
      rateSession= verfiyRateSession()
    end

    #click on view past conversion
    def clickOnViewPastCon()
      el= @driver.find_element(:xpath, "//a[@class='fR slide-left-btn']")
      el.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:xpath => "//span[text()='Rate This Session']").displayed? }
    end

    #click on rate session
    def clickRateSession()
      el= @driver.find_element(:xpath, "//span[text()='Rate This Session']")
      el.click
      wait = Selenium::WebDriver::Wait.new(:timeout => 10)
      wait.until { @driver.find_element(:xpath => "//h2[text()='What did you think?']").displayed? }
    end

    #Prodie the number of rating
    def giveRating(url)
      el= @driver.find_element(:xpath, "//a[@data-rating='3']")
      el.click
      @driver.get url
      sleep(5)

    end


    def verfiyRateSession()

      rateS= RateSessionDisplayed()
      #assert_equal rateS, false, "rate a session should not be shown"
      rateS
    end


    def RateSessionDisplayed()
      status= false
      begin
        @driver.find_element(:xpath, "//span[text()='Rate This Session']").displayed?
        status= true
      rescue Exception => e
        status= false
      end
      status
    end

##########################  Test Flag and Reply#################################################################

  #Verify that user can do a post flagged and reply on it
  def testFlagAction()
    clickOnMoreLink()
    clickOnFlagPost()
    clickOnConfirm()
    sleep(5)
    flag= verifyFlagged()
  end

  #click on more link
  def clickOnMoreLink()
    el= @driver.find_element(:xpath, "(//*[@id='posts']/li[2]/div[2]/a)[1]")
    el.click
    sleep(5)
    #wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    #wait.until { @driver.find_element(:xpath => "div.view-more-actions").displayed? }
  end

  #click on flag link
  def clickOnFlagPost()
    el= @driver.find_element(:xpath, "//div[@class='view-more-actions']/div/a[3]/span[contains(text(),'Flag Post')]")
    el.click
  end

  # click on yes, flag this post link
  def clickOnConfirm()
    el= @driver.find_element(:xpath, "//a[contains(text(),'Yes, Flag this Post')]")
    el.click
  end

  #Verify that user flagged a post
  def verifyFlagged()
    el= @driver.find_element(:xpath, "//div[@class='view-more-actions']/div/a[3]/span[contains(text(),'Flagged')]")
    ftext=el.text
   # assert_equal ftext, "Flagged", "Flagged text should be shown after performing flag action"
    ftext

  end

  #Verify that user can do a reply on post
  def testReplyAction(url)
    #clickOnMoreLink()
    clickOnReplyAndPost()
    clickOnPostAndRefreshed(url)
    sleep(5)
    verifyReplyPostDisplayed()
  end

  #Click on reply
  def clickOnReplyAndPost()
    el= @driver.find_element(:xpath, "//div[@class='view-more-actions']/div/a/span[contains(text(),'Reply')]")
    el.click
    sleep(5)
    el2= @driver.find_element(:xpath, "//*[@id='view']/section[3]/div/div[1]/div/div[2]/textarea")
    el2.clear
    el2.send_keys "This is my reply post"
  end

  #Click on the post button and refreshed the page
  def clickOnPostAndRefreshed(url)
    postLink= @driver.find_element(:link, "Post")
    postLink.click
    sleep(5)
    @driver.get url
  end

  #verify that replied post is displayed
  def verifyReplyPostDisplayed()
    result= replyDisplayed()
    #assert_equal result, true, "Reply post should be displayed"
    result
  end

  def replyDisplayed()
    status= false
    begin
      @driver.find_element(:css, "ul.replies-c").displayed?
      status= true
    rescue Exception => e
      status= false
    end
    status
   end
#*********************************** Test Remove Post ************************************************

  #Verify that user can remove the post
  def removePost()
    clickOnMoreLink()
    removePostByClickingRemoveLink()
    sleep(6)
    verfiyPostRemoved()

  end

  #Click on remove link and then click on confirm button
  def removePostByClickingRemoveLink()
   el= @driver.find_element(:xpath, "//div[@class='view-more-actions my-post']/div/a[4]/span[contains(text(),'REMOVE')]")
   el.click
   wait = Selenium::WebDriver::Wait.new(:timeout => 10)
   wait.until { @driver.find_element(:link => "Yes, Delete this Post").displayed? }
   el2= @driver.find_element(:link, "Yes, Delete this Post")
   el2.click
  end

  #Verfiy post removed properly
  def verfiyPostRemoved()
    result= RemovedPostExist()
    #assert_equal result, false, "Post should be removed"
  end

  def RemovedPostExist()
    status= false
    begin
      @driver.find_element(:xpath, "//*[@id='posts']/li[3]/div[1]/div[2]/div[2]/p").displayed?
      status= true
    rescue Exception => e
      status= false
    end
    status
  end

#***************************  Test Recent and Popular Sorting **************************************

  #Verify that user can provide the post at second time
  def provideSecondPost(url,postMessage)
    clickOnSchedule()
    clickJoinSession()
    #enterPost()
    enterPostMessage(postMessage)
    #uploadPhoto()
    clickOnPost()
    #clickOnPostAndVerifySuccessMsg()
    verifySecondPostDisplayed(url)
  end

  #Post is displayed
  def verifySecondPostDisplayed(url)
    @driver.navigate.refresh
    @driver.get url
    sleep(5)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    element = wait.until { @driver.find_element(:id => "posts") }

    el= @driver.find_element(:xpath, "//*[@id='posts']/li[2]/div[1]/div[2]/div[2]/p")
    postMsg= el.text
   # assert postMsg.include? "This is my recent post message"
  end

  #Verify that recent sorting is performed
  def recentSorting()
    clickOnSortingDropDown()
    selectRecentOption()
    sleep(5)
    verifyRecentPost()

  end

  #Select sorting drop down
  def clickOnSortingDropDown()
    el= @driver.find_element(:xpath, "//a[@data-selector='sorting-btn']")
    el.click
  end

  #Select recent option
  def selectRecentOption()
    el= @driver.find_element(:xpath, "//span[text()='Recent']")
    el.click
  end

  #Select popular option
  def selectPopularOption()
    el= @driver.find_element(:xpath, "//span[text()='Popular']")
    el.click
  end

  #Verify that recent post is displayed at the top
  def verifyRecentPost()
    el= @driver.find_element(:xpath, "//*[@id='posts']/li[2]/div[1]/div[2]/div[2]/p")
    recentPostMsg= el.text
    #assert recentPostMsg.include? "This is my recent post message"
  end

#Verify that user can perform popular sorting
  def popularSorting()
    clickOnSortingDropDown()
    selectPopularOption()
    sleep(5)
    verifyPopularPost()
  end

  #Verify that popular sorting is performed
  def verifyPopularPost()
    el= @driver.find_element(:xpath, "//*[@id='posts']/li[1]/div[1]/div[2]/div[2]/p")
    popularPostMsg= el.text
    #assert popularPostMsg.include? "This is my fist post of automation"
  end

end
