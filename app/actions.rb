helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end

get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  # @current_user = User.find_by(id: session[:user_id]) #move to helper
  erb(:index)
end

get '/login' do    # when a GET request comes into /login
  erb(:login)      # render app/views/login.erb
end

post '/login' do  # when we submit a form with an action of /login
  #params.to_s    # just display the params for now to make sure it's working
  username = params[:username]
  password = params[:password]

  @user = User.find_by(username: username)  

  if @user && @user.password == password
    session[:user_id] = @user.id
    #"Success! User with id #{session[:user_id]} is logged in!"
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end

get '/logout' do
  session[:user_id] = nil
  #"Logout successful!"
  redirect to('/')
end

get '/signup' do
  @user = User.new
  erb(:signup)
end

post '/signup' do
  # params.to_s
  # grab user input values from params
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  # instantiate a User
  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  # if all user params are present
  if @user.save
    # instantiate and save a User
    #escape_html user.inspect
    # "User #{username} saved!"
    redirect to('/login')
  else
    # display simple error message
    # escape_html user.errors.full_messages
    erb(:signup)
  end
end


get '/finstagram_posts/new' do
  #erb(:"finstagram_posts/new")
  @finstagram_post = FinstagramPost.new
  erb(:"finstagram_posts/new")
end

post '/finstagram_posts' do
  photo_url = params[:photo_url]

  # instantiate new FinstagramPost
  @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

  # if @post validates, save
  if @finstagram_post.save
    redirect(to('/'))
  else

    # if it doesn't validate, print error messages
    # @finstagram_post.errors.full_messages.inspect
    erb(:"finstagram_posts/new")
  end
end

get '/finstagram_posts/:id' do
  #params[:id]
  @finstagram_post = FinstagramPost.find(params[:id])   # find the finstagram post with the ID from the URL
  #escape_html @finstagram_post.inspect        # print to the screen for now
  erb(:"finstagram_posts/show")               # render app/views/finstagram_posts/show.erb
end

post '/comments' do
  #params.to_s
  # point values from params to variables
  text = params[:text]
  finstagram_post_id = params[:finstagram_post_id]

  # instantiate a comment with those values & assign the comment to the `current_user`
  comment = Comment.new({ text: text, finstagram_post_id: finstagram_post_id, user_id: current_user.id })

  # save the comment
  comment.save

  # `redirect` back to wherever we came from
  redirect(back)
end

post '/likes' do
  finstagram_post_id = params[:finstagram_post_id]

  like = Like.new({ finstagram_post_id: finstagram_post_id, user_id: current_user.id })
  like.save

  redirect(back)
end

delete '/likes/:id' do
  like = Like.find(params[:id])
  like.destroy
  redirect(back)
end

# def humanized_time_ago(time_ago_in_minutes)
#   if time_ago_in_minutes >= 60
#       "#{time_ago_in_minutes / 60} hours ago"
#   else
#       "#{time_ago_in_minutes} minutes ago"
#   end
# end
    

# get '/' do
  
#   @finstagram_post_shark = {
#     username: "sharky_j",
#     avatar_url: "http://naserca.com/images/sharky_j.jpg",
#     photo_url: "http://naserca.com/images/shark.jpg",
#     humanized_time_ago: humanized_time_ago(15),
#     like_count: 0,
#     comment_count: 1,
#     comments: [{
#       username: "sharky_j",
#       text: "Out for the long weekend... too embarrassed to show y'all the beach bod!"
#     }]
#   }

#   @finstagram_post_whale = {
#     username: "kirk_whalum",
#     avatar_url: "http://naserca.com/images/kirk_whalum.jpg",
#     photo_url: "http://naserca.com/images/whale.jpg",
#     humanized_time_ago: humanized_time_ago(65),
#     like_count: 0,
#     comment_count: 1,
#     comments: [{
#       username: "kirk_whalum",
#       text: "#weekendvibes"
#     }]
#   }

#   @finstagram_post_marlin = {
#     username: "marlin_peppa",
#     avatar_url: "http://naserca.com/images/marlin_peppa.jpg",
#     photo_url: "http://naserca.com/images/marlin.jpg",
#     humanized_time_ago: humanized_time_ago(190),
#     like_count: 0,
#     comment_count: 1,
#     comments: [{
#       username: "marlin_peppa",
#       text: "lunchtime! ;)"
#     }]
#   }
    
    # if time_ago_in_minutes > 60
    #     "more than an hour ago"
    # elsif time_ago_in_minutes == 60
    #     "an hour ago"
    # elsif time_ago_in_minutes <= 1
    #     "just a moment ago"    
    # else
    #     "less than an hour ago"
    # end
    
    
    # if time_ago_in_minutes >= 60
    #     "#{time_ago_in_minutes / 60} hours ago"
    # else
    #     "#{time_ago_in_minutes} minutes ago"
    # end
    
    #humanized_time_ago(finstagram_post[:time_ago_in_minutes])
    
    #finstagram_post.to_s
    
    #[@finstagram_post_shark, @finstagram_post_whale, @finstagram_post_marlin].to_s
    
# @finstagram_posts = [@finstagram_post_shark, @finstagram_post_whale, @finstagram_post_marlin]