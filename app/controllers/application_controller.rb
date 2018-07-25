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
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user == nil
      redirect to "/"
    end
    session[:id] = @user.id
    redirect '/users/home'

  end

  get '/account' do

  end

  get '/logout' do

  end


end
