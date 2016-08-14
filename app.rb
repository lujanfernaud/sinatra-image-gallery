class App < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "12345"
  end

  helpers do
    def loggedin?
      session[:loggedin]
    end
  end

  ["/images/:id/delete-confirmation", "/images/:id/delete"].each do |route|
    before route do
      redirect "/" if !session[:loggedin]
    end
  end

  # Index.
  get "/" do
    @images = Image.all
    haml :index
  end

  # Very simple and not safe login, for testing purposes.
  get "/login" do
    session[:loggedin] = true
    redirect "/"
  end

  # Very simple logout, for testing purposes.
  get "/logout" do
    session[:loggedin] = false
    redirect "/"
  end

  # Still not sure about keeping this feature or not.
  get "/images/:id" do
    @image = Image[params[:id]]
    haml :show
  end

  # Save image to database.
  post "/images" do
    @image = Image.new params[:image]
    @image.save
    redirect "/"
  end

  # Delete confirmation.
  get "/images/:id/delete-confirmation" do
    @image = Image[params[:id]]
    haml :delete_confirmation
  end

  # Delete image from database.
  get "/images/:id/delete" do
    @image = Image[params[:id]]
    @image.destroy
    redirect "/"
  end
end