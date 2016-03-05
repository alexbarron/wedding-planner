class WeddingsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/wedding' do
    if logged_in?
      if @wedding = current_user.wedding
        erb :'/wedding/show'
      else
        erb :'/wedding/no_wedding'
      end
    else
      login_redirect
    end
  end

  delete '/wedding/delete' do
    if logged_in?
      @wedding = current_user.wedding
      @wedding.destroy
      session[:message] = "Wedding deleted."
      redirect '/wedding'
    else
      login_redirect
    end
  end

  get '/wedding/new' do
    if logged_in? && !current_user.wedding
      erb :'/wedding/new'
    elsif current_user.wedding
      session[:message] = "You can't create more than 1 wedding per account. Please delete current wedding before creating another."
      redirect '/wedding'
    else
      login_redirect
    end
  end

  post '/wedding' do
    if logged_in? && params[:name] != ""
      Wedding.create(name: params[:name], location: params[:location], date: params[:date], user_id: current_user.id)
      redirect "/wedding"
    elsif params[:name] == ""
      session[:message] = "Name can't be empty."
      redirect "/wedding/new"
    else
      login_redirect
    end
  end

  get "/wedding/edit" do
    if logged_in?
      @wedding = current_user.wedding
      erb :'/wedding/edit'
    else
      login_redirect
    end
  end

  post "/wedding/edit" do
    if logged_in? && params[:name] != ""
      @wedding = current_user.wedding
      @wedding.update(name: params[:name], location: params[:location], date: params[:date])
      redirect "/wedding"
    elsif params[:name] == ""
      session[:message] = "Name can't be empty."
      redirect "/wedding/edit"
    else
      login_redirect
    end
  end

end