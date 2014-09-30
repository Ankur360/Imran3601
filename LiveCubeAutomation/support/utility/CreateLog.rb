
class CreateLog

	def LogStartExecution(message)
		time2 = Time.now
		message = time2.strftime("%Y-%m-%d %H:%M:%S")+ " [Info] "+ message
		filename = "ReportLog.text" 
		File.open "executionlog/"+filename, "a+" do |file|		
			file.write("*****************************************************************************\n")
			file.write(message+"\n")
			file.write("*****************************************************************************\n")
		end
	end

	def LogEndExecution(message)
		time2 = Time.now
		message = time2.strftime("%Y-%m-%d %H:%M:%S")+ " [Info] "+ message
		filename = "ReportLog.text"
		File.open "executionlog/"+filename, "a+" do |file|
			file.write(message+"\n")
			file.write("*****************************************************************************\n")
		end
	end

	def Log(message)
		time2 = Time.now
		message = time2.strftime("%Y-%m-%d %H:%M:%S")+ " [Info] "+ message
		filename = "ReportLog.text"
		File.open "executionlog/"+filename, "a+" do |file|
			file.write(message+"\n")			
		end
	end

	def createFile

	end
end

