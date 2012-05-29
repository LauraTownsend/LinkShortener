require 'sinatra'
require 'haml'

set :haml, :format => :html5
base = "http://localhost:8080/"
urls=Hash.new

get '/' do
	haml :index
end

post '/' do
	big_url = request.body.url
	small_id = hash.length+1

	urls.store(small_id,big_url)
	urls.store(big_url,small_id)

	%a{:href => url(base+'/'+small_id)} 
end

get '/:small' do 
	if urls[:small] == nil
		redirect to('/')
	else
		big_url = urls[:small]
		redirect to(big_url)
end