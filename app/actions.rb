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