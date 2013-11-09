require 'mongo'
require 'json'
require 'htmlentities'

include Mongo

mongo = MongoClient.new()
@db = mongo.db('quotes')

one = @db.collection('q').find_one({
	"_id" => BSON::ObjectId("527e2725cef2ea286400001a")
})
q = one['quote']
q = HTMLEntities.new.decode(q).gsub!(/(\r|\n|\t)/," ")
puts q