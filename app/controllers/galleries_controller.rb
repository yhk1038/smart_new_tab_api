class GalleriesController < ApplicationController
    before_action :set_gallery, only: [:show, :update, :destroy]

    # GET /galleries
    def index
        @galleries = Gallery.all

        arr = []
        @galleries.each do |gallery|
            next unless gallery.readable? params[:user_id]

            g = {}
            g[:id] = gallery.id
            g[:name] = gallery.name
            g[:photos] = gallery.photos.count
            g[:is_followed] = UserGallery.where(gallery: gallery, user_id: params[:user_id]).exists?
            g[:white_list] = gallery.white_list

            arr << g
        end

        render json: arr
    end

    # GET /galleries/1
    def show
        photo_arr = []
        @gallery.photos.each do |photo|
            h = {}
            h['obj'] = photo
            h['url'] = photo.image.url
            h['author'] = photo.author
            photo_arr << h
        end
        render json: [@gallery, @gallery.photos, @gallery.users.count, photo_arr]
    end

    # POST /galleries
    def create
        @gallery = Gallery.new(gallery_params)
        @user = User.find(params[:user_id])

        @gallery.white_list = nil if params[:gallery][:white_list].length.zero?

        if @gallery.save
            UserGallery.create(user: @user, gallery: @gallery)
            render json: @gallery, status: :created, location: @gallery
        else
            render json: @gallery.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /galleries/1
    def update
        if @gallery.update(gallery_params)
            render json: @gallery
        else
            render json: @gallery.errors, status: :unprocessable_entity
        end
    end

    # DELETE /galleries/1
    def destroy
        @gallery.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
        @gallery = Gallery.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gallery_params
        params.require(:gallery).permit(:name, :white_list)
    end
end
