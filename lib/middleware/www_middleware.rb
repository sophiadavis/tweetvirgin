class WwwMiddleware
	
	def initialize(app)
		@app = app
	end

	def call(env)
		#[200, {"Content-Type" => "text/html"}, "Hello, World!"]

		request = Rack::Request.new(env)
	
		if request.host.starts_with?("*.com")
			[301, {"Location" => request.url.sub("//*.", "//www.*.com")}, self]
		else
			@app.call(env)
		end
	end

	def each(&block)
	end
end