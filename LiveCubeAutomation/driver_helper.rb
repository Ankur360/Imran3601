require "selenium-webdriver"
#require "test/unit"
path = File.expand_path(File.dirname(__FILE__))
Dir[path+"/support/**/*.rb"].each {|file| require file }
require "json"
require "selenium-webdriver"
require "rspec"

class DriverHelper

  def initialize(driver)
    @driver = driver
  end

  def readAttendeesUrl()
    url=""
    f = File.open("attendeesUrl.txt", "r")
    f.each_line do |line|

      #puts line
      url=line
    end
    f.close
    url
	end

  
   
    
end