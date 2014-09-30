require ('rubygems')
# before running this class first install >gem install parseconfig
require ('parseconfig')

class ReadConfig

	#function to read .conf file
	def getApplication(key)
		path =  absolutePath()
		my_config = ParseConfig.new(path +'/config/config.conf') 
		value = my_config.params[key]
		return value
	end
	
	#function to get absolute path
	def absolutePath
		path = File.expand_path(File.dirname(File.dirname(__FILE__)))
		path = path.split("support").first
		return path
	end
	
end	

