get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by(email: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = "Wrong email or password"
    redirect '/login'
  end
end

get '/register' do
  erb :register
end

post '/register' do
  @user = User.new(params[:user])
  if @user.save
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
