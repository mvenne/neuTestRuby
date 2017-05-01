class TinymceAssetsController < ApplicationController
  respond_to :json

  def create

    @image = Image.new
    @image.file = image_params[:file]
    @image.save
    puts(@image.file_url)
    render :js => "<script>alert('Hello Rails');</script>"
   # render json: {
   #     location: @image.file_url
   # }, layout: false, content_type: "text/html"
  end

  private
  def image_params
    params.require(:image).permit(:file)
  end
end