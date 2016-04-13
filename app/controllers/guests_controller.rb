class GuestsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/guests' do
    if logged_in?
      @guests = current_user.guests
      erb :'/guests/index'
    else
      login_redirect
    end
  end

  get "/guests/new" do
    if logged_in?
      erb :'/guests/new'
    else
      login_redirect
    end
  end

  get "/guests/:id/edit" do
    if logged_in? && @guest = current_user.guests.find_by(id: params[:id])
      erb :'/guests/edit'
    else
      session[:message] = "That's not your guest!"
      redirect '/wedding'
    end
  end

  post "/guests" do
    if logged_in? && params[:name] != ""
      Guest.create(name: params[:name], role: params[:role], rsvp: params[:rsvp], wedding_id: current_user.wedding.id)
      redirect "/guests"
    elsif params[:name] == ""
      session[:message] = "Name can't be empty."
      redirect "/guests/new"
    else
      login_redirect
    end
  end

  post "/guests/:id" do
    @guest = current_user.guests.find_by(id: params[:id])
    if logged_in? && params[:name] != ""
      @guest.update(name: params[:name], role: params[:role], rsvp: params[:rsvp])
      redirect "/guests/#{@guest.id}"
    elsif params[:name] == ""
      session[:message] = "Name can't be empty."
      redirect "/guests/#{@guest.id}/edit"
    else
      login_redirect
    end
  end

  get '/guests/:id' do
    if logged_in? && @guest = current_user.guests.find_by(id: params[:id])
      erb :'/guests/show'
    else
      session[:message] = "That's not your guest!"
      redirect '/wedding'
    end
  end

  delete '/guests/:id/delete' do
    @guest = current_user.guests.find_by(id: params[:id])
    if logged_in? && @guest.destroy
      session[:message] = "Guest deleted."
      redirect '/guests'
    else
      login_redirect
    end
  end

end