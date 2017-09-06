class PhotosController < ApplicationController
    before_action :set_photo, only: [:show, :update, :destroy]

    # GET /photos
    def index
        @photos = Photo.all

        render json: @photos
    end

    # GET /photos/1
    def show
        render json: @photo
    end

    # POST /photos
    def create
        @photo = Photo.new(photo_params)

        if @photo.save
            render json: @photo, status: :created, location: @photo
        else
            render json: @photo.errors, status: :unprocessable_entity
        end
    end

    # POST /set_file/:gallery_id
    def set_file
        gallery_id = params[:gallery_id]
        file = params[:image_file]
        file_name = file.original_filename

        # path = "/uploads/#{gallery_id}/#{file_name}"
        @photo = Photo.new(
                 gallery_id: gallery_id,
                 url: file_name,
                 image: file
        )
        if @photo.save
            render json: @photo, status: :created, location: @photo
        else
            render json: @photo.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /photos/1
    def update
        if @photo.update(photo_params)
            render json: @photo
        else
            render json: @photo.errors, status: :unprocessable_entity
        end
    end

    # DELETE /photos/1
    def destroy
        @photo.destroy
        render json: @photo
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
        @photo = Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
        params.require(:photo).permit(:gallery_id, :image)
    end
end
