class App < Sinatra::Base
  get "/" do
    @images = Image.all
    haml :index
  end

  get "/images/:id" do
    @image = Image[params[:id]]
    haml :show
  end

  post "/images" do
    @image = Image.new params[:image]
    @image.save
    redirect "/"
  end

  get "/images/:id/delete-confirmation" do
    @image = Image[params[:id]]
    haml :delete_confirmation
  end

  get "/images/:id/delete" do
    @image = Image[params[:id]]
    @image.destroy
    redirect "/"
  end
end