#!/usr/bin/ruby
#CIT 383 - Project 3
#Apache Common Log Parser - written by Brendan Ryan

class CommonLog

	#assign input file to variable
	def initialize(logFile)
		@filename = logFile
		@file = File.open(logFile).read
	end
	
	#create IP histogram
	def generateIP
		
		totalBytes = 0	
		ipArray = Array.new(0)
		
		#split up line and store into variables
		@file.each_line do |line|
			time = line.slice!(/\[.*?\]/)
			request = line.slice!(/".*"/)
			ip, identity, username, status, size = line.split
			ipArray.push(ip)
			totalBytes += size.to_i
		end
		
		#loop through data and output histogram
		frequency = Hash.new(0)
		ipArray.each{ |address| frequency[address] += 1 }
		frequency = frequency.sort_by {|a, b| b }
		frequency.reverse!
		frequency.each { |address, result| puts address + " : " + result.to_s }
		puts "\nFile name: #{@filename}"
		puts "Total bytes: #{totalBytes}"
	end
	
	#create URL histogram
	def generateURL
		
		totalBytes = 0
		url = Array.new(0)
		
		#split up line and store into variables
		@file.each_line do |line|
			time = line.slice!(/\[.*?\]/)
			request = line.slice!(/".*"/)
			ip, identity, username, status, size = line.split
			url.push(request)
			totalBytes += size.to_i
		end
		
		#loop through data and output histogram
		frequency = Hash.new(0)
		url.each{ |address| frequency[address] += 1 }
		frequency = frequency.sort_by {|a, b| b }
		frequency.reverse!
		frequency.each { |address, result| puts address + " : " + result.to_s }
		puts "\nFile name: #{@filename}"
		puts "Total bytes: #{totalBytes}"
	end
	
	#create requests per hour histogram
	def generateRPH
		
		totalBytes = 0
		rph = Array.new(0)
	
		#split up line and store into variables
		@file.each_line do |line|
			time = line.slice!(/\[.*?\]/)
			request = line.slice!(/".*"/)
			ip, identity, username, status, size = line.split
			rph.push(time[13..14])
			totalBytes += size.to_i
		end
		
		#loop through data and output histogram
		frequency = Hash.new(0)
		rph.each{ |address| frequency[address] += 1 }
		frequency = frequency.sort_by {|a, b| a }
		frequency.each { |address, result| puts address + " : " + result.to_s }
		puts "\nFile name: #{@filename}"
		puts "Total bytes: #{totalBytes}"
	end
	
	#create HTTP status histogram
	def generateStatus
		
		totalBytes = 0
		httpCode = Array.new(0)
	
		#split up line and store into variables
		@file.each_line do |line|
			time = line.slice!(/\[.*?\]/)
			request = line.slice!(/".*"/)
			ip, identity, username, status, size = line.split
			httpCode.push(status)
			totalBytes += size.to_i
		end
		
		total = 0
		
		#loop through data and output histogram
		frequency = Hash.new(0)
		httpCode.each{ |address| frequency[address] += 1; total += 1 }
		frequency = frequency.sort_by {|a, b| a }
		frequency.each { |address, result| puts address + " : " + (result*100/total).to_s + "%" }
		puts "\nFile name: #{@filename}"
		puts "Total bytes: #{totalBytes}"
	end
end

#initialize CommonLog and call functions
start = CommonLog.new('test_log')
puts "\nIP Histogram:\n"
start.generateIP
puts "\nURL Request Histogram:\n"
start.generateURL
puts "\nRequests Per Hour:\n"
start.generateRPH
puts "\nPercentage of HTTP Statuses:"
start.generateStatus
