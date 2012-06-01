require 'sinatra'
require 'haml'
require 'mongo'

set :haml, :format => :html5
base = "http://localhost:4567/"
urls=Hash.new
conn = Mongo::Connection.new #(host, port)
db   = conn['links']
coll = db['link']

get '/' do
	haml :index
end

post '/' do
	@big_url = params["url"]
	small_id = urls.length+1
	if urls.has_key?(@big_url)
		@small = urls["#{@big_url}"]
		#@small = 
		haml :existsAlready
	#page which shows big url and small one already stored
	else
		urls.store(small_id,@big_url)
		urls.store(@big_url,small_id)
		#coll.insert({small_id => @big_url})
		#coll.insert({@big_url => small_id})
		@small_url = "#{base}#{small_id}"
		haml :urlstored
	end
	
end

get '/:small' do |id|
	if urls.has_key?("#{id}".to_i) #if
		big_url = urls["#{id}".to_i]
		#big_url =
		redirect to("http://#{big_url}")
	else
		haml :error
	end
end
