class GuestsController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/guests' do
    if logged_in?
      @guests = current_user.wedding.guests
      erb :'/guests/index'
    else
      redirect '/login', locals: {message: "Please log in to see that."}
    end
  end

  get "/guests/new" do
    if logged_in?
      erb :'/guests/new'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get "/guests/:id/edit" do
    if logged_in?
      @guest = Guest.find(params[:id])
      erb :'/guests/edit'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/guests" do
    if logged_in? && params[:name] != ""
      Guest.create(name: params[:name], rsvp: params[:rsvp], wedding_id: current_user.wedding.id)
      redirect "/guests"
    elsif params[:name] == ""
      redirect "/guests/new", locals: {message: "Name can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/guests/:id" do
    @guest = Guest.find(params[:id])
    if logged_in? && params[:name] != ""
      @guest.update(name: params[:name], rsvp: params[:rsvp])
      redirect "/guests/#{@guest.id}"
    elsif params[:name] == ""
      redirect "/guests/#{@guest.id}/edit", locals: {message: "Name can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get '/guests/:id' do
    if logged_in?
      @guest = Guest.find(params[:id])
      erb :'/guests/show'
    else
      redirect '/login', locals: {message: "Please log in to see that."}
    end
  end

  delete '/guests/:id/delete' do
    @guest = Guest.find(params[:id])
    if logged_in? && @guest.wedding.user == current_user
      @guest.destroy
      redirect '/guests'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

end