require 'sinatra'
require 'haml'

set :haml, :format => :html5
base = "http://localhost:4567/"
urls=Hash.new

get '/' do
	haml :index
end

post '/' do
	big_url = request.body.url
	small_id = urls.length+1

	urls.store(small_id,big_url)
	urls.store(big_url,small_id)
	@small_url = base+'/'+small_id
	haml :urlstored
	
end

get '/url/:small' do 
	if urls[params[:small]] == nil 
		redirect to('/')
	else
		big_url = urls[params[:small]]
		redirect to(big_url)
	end
end
