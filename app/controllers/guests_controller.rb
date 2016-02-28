class GuestsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/guests") }

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/guests' do
    if logged_in?
      @guests = current_user.wedding.guests
      erb :index
    else
      redirect '/login', locals: {message: "Please log in to see that."}
    end
  end

  get '/guests/:id' do
    if logged_in?
      @guest = Guest.find(params[:id])
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