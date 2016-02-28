class WeddingsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/weddings") }

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/wedding' do
    if logged_in?
      @wedding = current_user.wedding
      erb :show
    else
      redirect '/login', locals: {message: "Please log in to see that."}
    end
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