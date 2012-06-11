require 'sinatra'
require 'haml'
require 'pstore'

set :haml, :format => :html5
base = "http://localhost:4567/"
#urls=Hash.new
# a new PStore file which stores key-value pairs in a file called urlstore
store = PStore.new('urlstore')
small_id = 0
store.transaction do
	store.roots.each {small_id+=1}
end
get '/' do
	haml :index
end

post '/' do
	@big_url = params["url"]
	small_id = small_id+1
	###using pstore to store the urls
	store.transaction do 
		if store.root?(@big_url)
			@small = store["#{@big_url}"]
			haml :existsAlready
		else
			store[small_id]=@big_url
			store[@big_url]=small_id
			@small_url = "#{base}#{small_id}"
			haml :urlstored
		end
	end
	###using a hash to store the urls
	#if urls.has_key?(@big_url)
	#	@small = urls["#{@big_url}"]
		#@small = 
	#	haml :existsAlready
	#page which shows big url and small one already stored
	#else
	#	urls.store(small_id,@big_url)
	#	urls.store(@big_url,small_id)
	#	@small_url = "#{base}#{small_id}"
	#	haml :urlstored
	#end
	
end

get '/:small' do |id|
	###using pstore to find corresponding url
	store.transaction do
		if store.root?("#{id}".to_i)
			big_url = store["#{id}".to_i]
			redirect to("http://#{big_url}")
		else
			haml :error
		end
	end

	### using hash to find corresponding url
	#if urls.has_key?("#{id}".to_i) #if
	#	big_url = urls["#{id}".to_i]
	#	redirect to("http://#{big_url}")
	#else
	#	haml :error
	#end
end
