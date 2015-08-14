require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative './helpers/session_helpers'
require './app/controllers/base'

require './app/controllers/user'
require './app/controllers/link'
require './app/controllers/tag'
require './app/controllers/session'


module Bob
  class App < Sinatra::Base

    # use Rack::MethodOverride
    # enable :sessions
    # set :session_secret, 'super secret'
    # register Sinatra::Flash
    # register Sinatra::Partial
    # set :partial_template_engine, :erb
    # enable :partial_underscores

    use Routes::LinkController
    use Routes::UserController
    use Routes::TagController
    use Routes::SessionController

    get '/' do
      erb :index
    end

    # get '/links' do
    #   @links = Link.all
    #   erb :'links/index'
    # end

    # get '/links/new' do
    #   erb :new_link
    # end

    # post '/links' do
    #   link = Link.create(url: params[:url], title: params[:title])
    #   unless params[:tag] == ''
    #     tag = Tag.create(name: params[:tag])
    #     link.tags.push(tag)
    #     link.save
    #   end
    #   redirect '/links'
    # end

    # get '/tags/:name' do
    #   tag = Tag.first(name: params[:name])
    #   @links = tag ? tag.links : []
    #   erb :'links/index'
    # end

    # get '/users/new' do
    #   @user = User.new
    #   erb :'users/new'
    # end

    # post'/users' do
    #   @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    #   if @user.save
    #     session[:user_id] = @user.id
    #     redirect to('/links')
    #   # elsif params[:email] == ''
    #   #   flash.now[:notice] = "You must enter an email to sign up"
    #   else
    #     flash.now[:errors] = @user.errors.full_messages
    #       erb :'users/new'
    #   end
    # end

    # get '/sessions/new' do
    #   erb :'sessions/new'
    # end

    # post '/sessions' do
    #   user = User.authenticate(params[:email], params[:password])
    #   if user
    #     session[:user_id] = user.id
    #     redirect to('/links')
    #   else
    #     flash.now[:errors] = ['The email or password is incorrect']
    #     erb :'sessions/new'
    #   end
    # end

    # delete '/sessions' do
    #   session.clear
    #   flash[:notice] = 'You are now logged out'
    #   redirect'/'
    # end

    # helpers do
    #   def current_user
    #     User.get(session[:user_id])
    #   end
    # end


    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
