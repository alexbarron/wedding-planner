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
      redirect '/login', locals: {message: "Please log in to see that."}
    end
  end

  delete '/wedding/delete' do
    if logged_in?
      @wedding = current_user.wedding
      @wedding.destroy
      redirect '/wedding'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get '/wedding/new' do
    if logged_in? && !current_user.wedding
      erb :'/wedding/new'
    elsif current_user.wedding
      redirect '/wedding', locals: {message: "You can't create more than 1 wedding per account."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post '/wedding' do
    if logged_in? && params[:name] != ""
      Wedding.create(name: params[:name], location: params[:location], date: params[:date], user_id: current_user.id)
      redirect "/wedding"
    elsif params[:name] == ""
      redirect "/wedding/new", locals: {message: "Name can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  get "/wedding/edit" do
    if logged_in?
      @wedding = current_user.wedding
      erb :'/wedding/edit'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

  post "/wedding/edit" do
    if logged_in? && params[:name] != ""
      @wedding = current_user.wedding
      @wedding.update(name: params[:name], location: params[:location], date: params[:date])
      redirect "/wedding"
    elsif params[:name] == ""
      redirect "/wedding/edit", locals: {message: "Name can't be empty."}
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

end