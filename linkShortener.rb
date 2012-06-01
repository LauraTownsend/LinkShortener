require 'sinatra'
require 'haml'

set :haml, :format => :html5
base = "http://localhost:4567/"
urls=Hash.new

get '/' do
	haml :index
end

post '/' do
	@big_url = params["url"]
	small_id = urls.length+1
	if urls.has_key?(@big_url)
		puts "#{@big_url}"
		@small = urls["#{@big_url}"]
		puts @small
		haml :existsAlready
	#page which shows big url and small one already stored
	else
		urls.store(small_id,@big_url)
		urls.store(@big_url,small_id)
		@small_url = "#{base}#{small_id}"
		haml :urlstored
	end
	
end

get '/:small' do |id|
	if urls.has_key?("#{id}".to_i)
		big_url = urls["#{id}".to_i]
		redirect to("http://#{big_url}")
	else
		redirect to('http://localhost:4567/error')
	end
end

get '/error' do 
	haml :error
end