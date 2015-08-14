module Bob
  module Routes
    class Base < Sinatra::Base
      #add config common to all routes
       use Rack::MethodOverride
    enable :sessions
    set :session_secret, 'super secret'
    register Sinatra::Flash
    register Sinatra::Partial
    set :partial_template_engine, :erb
    enable :partial_underscores

    set :views, Proc.new { File.join(root, '..', 'views') }

      helpers do
      def current_user
        User.get(session[:user_id])
      end
    end

    end
  end
end