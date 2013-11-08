require 'open-uri'
require 'mongo'
include Mongo

mongo = MongoClient.new()
@db = mongo.db('quotes')

"Now inserting 1000 quotes to the database"
skips = 0
for i in 0..100
	output = ''
	open("http://iheartquotes.com/api/v1/random") { |f|
		f.each_line {|line| output << line}
	}
	# remove advertisement on last line
	output = output.split("\n")
	output.pop
	output = output.join("")
	p "====== CONGRATS. HAS A QUOTE " + i.to_s + " ===="
	p output
	p "==================================="
	check = @db.collection('q').find_one({
		"quote" => output
	}).to_a.length
	if check > 0
		p "   == [Quote already in DB, skip...]"
		skip += 1
		next
	end
	# insert
	insert = @db.collection('q').insert({
		"quote" => output})
	p "======   INSERT RECEIPT     ======"
	p insert
	p "=================================="
end
p "Operation complete with " + skips.to_s + " skips"