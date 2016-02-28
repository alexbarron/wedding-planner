class VendorsController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/vendors") }

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/vendors' do
    if logged_in?
      @vendors = current_user.wedding.vendors
      erb :index
    else
      redirect '/login', locals: {message: "Please log in to see that."}
    end
  end

  get '/vendors/:id' do
    if logged_in?
      @vendor = Vendor.find(params[:id])
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