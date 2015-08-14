module Bob
  module Routes
    class LinkController < Base

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


    end
  end
end