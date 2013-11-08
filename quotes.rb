require 'open-uri'
require 'mongo'
include Mongo

mongo = MongoClient.new()
@db = mongo.db('quotes')

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
	puts ":::On digest (" + i.to_s + ") found a quote:::\n"
	p
	puts "\t" + output
	p
	check = @db.collection('q').find_one({
		"quote" => output
	}).to_a.length
	if check > 0
		puts "[Quote already in DB, skip...]"
		skips += 1
		next
	end
	# insert
	insert = @db.collection('q').insert({
		"quote" => output})
	puts ":::INSERT RECEIPT: " + insert.to_s + ":::"
	puts "==================================="
end
puts "OPERATION COMPLETE: Inserted " + i.to_s + " quotes with " + skips.to_s + " skips"