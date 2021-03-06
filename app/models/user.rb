class User < ActiveRecord::Base
	attr_accessible :created_at, :first_tweet, :latest_tweet, :num_followers, :num_friends, :num_tweets, :profile_link, :user_id, :username, :timeoflasttweet, :over3200, :protected

	# grab user info from Twitter
	def self.get_user_info username
		
		user = Twitter.user(username)
	
		User.create!({
			:created_at => user.created_at,
			:first_tweet => 'no first tweet!',
			:latest_tweet =>  'no tweets!',
			:num_followers => user.followers_count,
			:num_friends => user.friends_count,
			:num_tweets => user.statuses_count,
			:profile_link => user.profile_image_url_https( size = :bigger ),
			:user_id => user.id,
			:username => username,
			:timeoflasttweet => nil,
			:over3200 => false,
			:protected => user.protected,
		})
		
	end

	# return the first tweet of a user (API can only access a user's last 3200 tweets)
	def self.get_first_tweet username
	
		timeline = Twitter.user_timeline(username, :count => 200)
		
		id = timeline.last.id
		id_checker = 0
		
		while id_checker != id do
			timeline = Twitter.user_timeline(username, :count => 200, :max_id => id)
			id_checker = id
			id = timeline.last.id
		end
		return timeline.last.text
	end

=begin	Eventually, I was going to add a twitter-score calculator! but that will take a lot
of research...
	def self.get_tweet_score
	
		tweet_score = 0
	
		# parse through last 200 tweets
		#timeline = Twitter.user_timeline(username, :count => 100)
		#id = timeline.last.id
		
		# parse through last 500 tweets
		for i in 0..4
			timeline = Twitter.user_timeline(username, :count => 200, :max_id => id)
			id = timeline.last.id
		end
	end
=end

end