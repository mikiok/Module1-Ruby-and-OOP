class Post
	attr_reader :tittle, :date, :text, :sponsored
	def initialize (tittle, date, text, sponsored=false)
		@tittle = tittle
		@date = date
		@text = text
		@sponsored = sponsored
	end
end

class Blog
	def initialize
		@posts=[]
	end
	def add_post(post)
		@posts.push(post)
	end
	def publish_front_page
		ordered_posts = order_posts_by_date
		ordered_posts.map do |post|
        	post_title = get_customize_title post
    		puts "#{post_title}\n********************\n#{post.text}\n"
    	end
	end
	private
	def order_posts_by_date
		@posts.sort_by {|post| post.date}
	end
	def get_customize_title post
    	post.sponsored ? "******#{post.tittle}******" : "#{post.tittle}"
  	end
end

blog = Blog.new

blog.add_post Post.new "Post 1", Time.now, "Ironhack post1", true
sleep(1)
blog.add_post Post.new "Post 2", Time.now, "Ironhack post2", false
blog.publish_front_page