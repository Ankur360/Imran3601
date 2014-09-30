
require "selenium-webdriver"

class SupportHelper
    
	def initialize(driver)
		@driver = driver
	end

	#function to check element present on page
	def element_present?(how, what)
      @driver.find_element(how, what)
      true
  		rescue Selenium::WebDriver::Error::NoSuchElementError
      false
	end

    #function to select drop down box using css ID
	def selectByID(element, value)
		country_select = @driver.find_element(:id, element)	
		options=country_select.find_elements(:tag_name=>"option")
		options.each do |g|
		  if g.text == value
			g.click
			break
		  end
		end
	end
	
	#function mouse opve on link
	def mouseOverUser
		menu = @driver.find_element(:xpath => "//*[@id='user_hover_menu']/a")
		submenu = @driver.find_element(:link => "Account")
		@driver.action.move_to(menu).click(submenu).perform		
	end
	
	def waitElementDisplay(element)
		wait = Selenium::WebDriver::Wait.new(:timeout => 10)
		wait.until { @driver.find_element(:id => "'"+element+"'").displayed? }
	end
	
end
