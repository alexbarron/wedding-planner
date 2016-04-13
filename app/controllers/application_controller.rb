class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }
  set :method_override, true

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if !logged_in?
      erb :signup
    else
      session[:message] = "You're already logged in!"
      redirect '/wedding'
    end
  end

  post "/signup" do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      user = User.create(username: params[:username], email: params[:username], password: params[:password])
      session[:id] = user.id
      session[:message] = "Successfully signed up."
      redirect '/wedding'
    else
      session[:message] = "Sign up failed, try again."
      redirect '/signup'
    end
  end

  get "/login" do
    if !logged_in?
      erb :login
    else
      session[:message] = "You're already logged in!"
      redirect '/wedding'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      session[:message] = "Successfully logged in."
      redirect '/wedding'
    else
      session[:message] = "Log in failed, try again."
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    session[:message] = "Successfully logged out."
    redirect "/"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end

    def login_redirect
      session[:message] = "Please log in to see that."
      redirect '/login'
    end
  end
end