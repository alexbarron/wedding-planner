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
    @wedding = current_user.wedding
    if logged_in?
      @wedding.destroy
      redirect '/'
    else
      redirect "/login", locals: {message: "Please log in to see that."}
    end
  end

end