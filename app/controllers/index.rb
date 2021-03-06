require 'intercom'

intercom = Intercom::Client.new(token: "my token")

get '/' do
  @users = User.all
  @user = current_user
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by_email(params[:email])
  # if @user && @user.authenticate(params[:password])
  p @user.password
  p params[:password]

  if @user.password == params[:password]
    p "OKOKOK"
    session[:user_id] = @user.id
    redirect '/'
  else
    p "SCREWWWYYY"
    @errors = "Wrong email or password"
    redirect '/login'
  end
end

get '/register' do
  erb :register
end

post '/register' do
  @user = User.new(params[:user])
  # @user.password = params[:password]
  if @user.save
    user = intercom.users.create(email: @user.email, name: @user.name)
    user.custom_attributes["favorite_beer"] = @user.favorite_beer
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = "Pick something else"
    redirect '/register'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
