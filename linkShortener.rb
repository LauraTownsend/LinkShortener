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
		redirect to('/')
	else
		urls.store(small_id,@big_url)
		urls.store(@big_url,small_id)
		@small_url = "#{base}#{small_id}"
		haml :urlstored
	end
	
end

get '/:small' do 
	if urls[params[:small]] == nil 
 		urls.each do |one,two|
			puts "#{one}: #{two}"		
		end
		big_url = urls[params[:small]]
		puts big_url
		puts urls.length
		#redirect to('/')
	else
		big_url = urls[params[:small]]
		puts big_url
		redirect to(big_url)
	end
end
