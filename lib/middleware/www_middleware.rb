# I wanted to use rack middleware to get tweetvirgin.com to redirect to www.tweetvirgin.com
# but I never got it working.

class WwwMiddleware
	
	def initialize(app)
		#logger.info("initialized")
		@app = app
	end

	def call(env)
=begin
		request = Rack::Request.new(env)
		
		unless request.ssl?
			url = request.url.sub(“http://&#8221;,”https://&#8221;)
			url = url.sub(“//tweetvirgin.com”, “//www.tweetvirgin.com”)
			[301, {"Location" => url}, self]
		
		#[200, {"Content-Type" => "text/html"}, "Hello, World!"]
=end
		request = Rack::Request.new(env)
		#logger.info request.inspect
		if request.host.starts_with?("*.com")
			[301, {"Location" => request.url.sub("//*.", "//www.*.com")}, self]

		else
			@app.call(env)
		end
	end

	def each(&block)
	end
end