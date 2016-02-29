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
      redirect '/', locals: {message: "You're already logged in!"}
    end
  end

  post "/signup" do
    if params[:username] != "" && params[:password] != ""
      User.create(username: params[:username], email: params[:username], password: params[:password])
      redirect '/', locals: {message: "Sign up successful, please log in now."}
    else
      redirect '/signup', locals: {message: "Sign up failed, try again."}
    end
  end

  get "/login" do
    if !logged_in?
      erb :login
    else
      redirect '/', locals: {message: "You're already logged in!"}
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/', locals: {message: "Successfully logged in."}
    else
      redirect "/login", locals: {message: "Log in failed, try again."}
    end
  end

  get "/logout" do
    session.clear
    redirect "/", locals: {message: "Successfully logged out."}
  end

  helpers do
    def logged_in?
      session[:id] ? true : false
    end

    def current_user
      User.find(session[:id])
    end
  end
end