require 'open-uri'
require 'mongo'
include Mongo

mongo = MongoClient.new()
@db = mongo.db('quotes')

class String
	def brown;         "\033[33m#{self}\033[0m" end
	def gray;           "\033[37m#{self}\033[0m" end
	def bg_blue;        "\033[44m#{self}\033[0m" end
	def bold;           "\033[1m#{self}\033[22m" end
	def green;          "\033[32m#{self}\033[0m" end
	def red;            "\033[31m#{self}\033[0m" end
end

puts "Now inserting " + ARGV[0].to_s + " quotes to the database"
skips = 0
for i in 0..ARGV[0].to_i
	output = ''
	open("http://iheartquotes.com/api/v1/random") { |f|
		f.each_line {|line| output << line}
	}
	# remove advertisement on last line
	output = output.split("\n")
	output.pop
	output = output.join("")
	puts ":::On digest (".green + i.to_s.green + ") found a quote:::".green
	p
	puts "\t" + output.bg_blue
	p
	check = @db.collection('q').find_one({
		"quote" => output
	}).to_a.length
	if check > 0
		puts "[Quote already in DB, skip...]".red
		skips += 1
		next
	end
	# insert
	insert = @db.collection('q').insert({
		"quote" => output})
	puts ":::INSERT RECEIPT::: ".brown + insert.to_s.gray
end
puts "\n\n"
puts "\t" + "OPERATION COMPLETE!" + " Inserted " + i.to_s + " quotes with " + skips.to_s + " skips"
puts "\n"