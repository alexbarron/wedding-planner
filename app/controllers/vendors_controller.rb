class VendorsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/vendors' do
    if logged_in?
      @vendors = current_user.wedding.vendors
      erb :'/vendors/index'
    else
      login_redirect
    end
  end

  get "/vendors/new" do
    if logged_in?
      erb :'/vendors/new'
    else
      login_redirect
    end
  end

  get "/vendors/:id/edit" do
    if logged_in?
      @vendor = Vendor.find(params[:id])
      erb :'/vendors/edit'
    else
      login_redirect
    end
  end

  post "/vendors" do
    if logged_in? && params[:name] != ""
      Vendor.create(name: params[:name], title: params[:title], cost: params[:cost].to_i, wedding_id: current_user.wedding.id)
      redirect "/vendors/#{Vendor.last.id}"
    elsif params[:name] == ""
      session[:message] = "Name can't be empty."
      redirect "/vendors/new"
    else
      login_redirect
    end
  end

  post "/vendors/:id" do
    @vendor = Vendor.find(params[:id])
    if logged_in? && params[:name] != ""
      @vendor.update(name: params[:name], title: params[:title], cost: params[:cost], wedding_id: current_user.wedding.id)
      redirect "/vendors/#{@vendor.id}"
    elsif params[:name] == ""
      session[:message] = "Name can't be empty."
      redirect "/vendors/#{@vendor.id}/edit"
    else
      login_redirect
    end
  end

  get '/vendors/:id' do
    if logged_in?
      @vendor = Vendor.find(params[:id])
      erb :'/vendors/show'
    else
      login_redirect
    end
  end

  delete '/vendors/:id/delete' do
    @vendor = Vendor.find(params[:id])
    if logged_in? && @vendor.wedding.user == current_user
      @vendor.destroy
      session[:message] = "Vendor deleted."
      redirect '/vendors'
    else
      login_redirect
    end
  end

end