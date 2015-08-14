module Bob
  module Routes
    class UserController < Base

       get '/users/new' do
      @user = User.new
      erb :'users/new'
    end

    post'/users' do
      @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      if @user.save
        session[:user_id] = @user.id
        redirect to('/links')
      # elsif params[:email] == ''
      #   flash.now[:notice] = "You must enter an email to sign up"
      else
        flash.now[:errors] = @user.errors.full_messages
          erb :'users/new'
      end
    end

    end
  end
end