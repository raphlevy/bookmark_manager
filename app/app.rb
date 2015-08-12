require 'sinatra/base'
require_relative 'data_mapper_setup'

class App < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    'Hello App!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :new_link
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    unless params[:tag] == ''
      tag = Tag.create(name: params[:tag])
      link.tags.push(tag)
      link.save
    end
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post'/users' do
    user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect to('/links')
  end

  helpers do
    def current_user
      User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
