class WeddingsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/weddings") }

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/weddings' do
    if logged_in?
      @weddings = current_user.weddings
      erb :index
    else
      redirect '/login', locals: {message: "Please log in to see that."}
    end
  end

  get '/weddings/:id' do
    @wedding = Wedding.find(params[:id])
    erb :show
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