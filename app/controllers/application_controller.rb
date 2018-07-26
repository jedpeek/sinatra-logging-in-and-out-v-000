require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user != nil && @user.password == params["password"]
      session[:user_id] = @user.id
      redirect '/account'
    else
      redirect to "error"

      @user = User.find_by(email: params["email"], password: params["password"])
      if @user == nil
        session[:user_id] = @user.id
        redirect to "/account"
      end
      session[:id] = @user.id
      redirect to "error"
    end

  end

  get '/error' do
    erb :'error'
  end

  get '/account' do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      erb :'/account'
    else
      erb :'/error'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end


end
