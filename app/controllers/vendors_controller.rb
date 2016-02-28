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

  get "/vendors/new" do
    if logged_in?
      erb :new
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get "/vendors/:id/edit" do
    if logged_in?
      @vendor = Vendor.find(params[:id])
      erb :edit
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/vendors" do
    if logged_in? && params[:name] != ""
      Vendor.create(name: params[:name], title: params[:title], cost: params[:cost].to_i, wedding_id: current_user.wedding.id)
      redirect "/vendors/#{Vendor.last.id}"
    elsif params[:name] == ""
      redirect "/vendors/new", locals: {message: "Name can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/vendors/:id" do
    @vendor = Vendor.find(params[:id])
    if logged_in? && params[:name] != ""
      @vendor.update(name: params[:name], title: params[:title], cost: params[:cost], wedding_id: current_user.wedding.id)
      redirect "/vendors/#{@vendor.id}"
    elsif params[:name] == ""
      redirect "/vendors/#{@vendor.id}/edit", locals: {message: "Name can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
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