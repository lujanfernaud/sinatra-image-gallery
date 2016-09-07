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
    @images = Image.all.reverse
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

  # Save image to database.
  post "/images" do
    @image_params = params[:image]
    if @image_params["file"][:filename] =~ /^.*\.(jpg|JPG|png|PNG)$/
      @image = Image.new params[:image]
      @image.save
    end
    redirect "/"
  end

  # Update image information in the database.
  post "/images/:id/edit" do
    @image = Image[params[:id]]
    if params["image-file"] != ""
      @image.update(:file => params["image-file"])
    end
    if params["image-title"] != ""
      @image.update(:title => params["image-title"])
    end
    redirect "/"
  end

  # Delete image from database.
  post "/images/:id/delete" do
    @image = Image[params[:id]]
    @image.destroy
    redirect "/"
  end
end