class UserGalleriesController < ApplicationController
    # before_action :set_user_gallery, only: []

    # GET /user_galleries
    def index
        @user_galleries = UserGallery.all

        render json: @user_galleries
    end

    # GET /user_galleries/1
    def show
        data = []

        # version < 0.2.2
        if params[:ids]
            @user_galleries = UserGallery.where(id: params[:ids])
            data = @user_galleries.map{|s| s.gallery.photos.map{|a| a.full_url}}.flatten
        end

        # version >= 0.2.3
        if params[:user_id]
            user = User.find(params[:user_id])
            @galleries = user.galleries if user
            data = @galleries.map{|g| g.photos.map{|a| a.full_url}}.flatten
        end

        render json: data
    end

    # POST /user_galleries
    def create
        @user_gallery = UserGallery.new(user_gallery_params)

        if @user_gallery.save
            render json: @user_gallery, status: :created, location: @user_gallery
        else
            render json: @user_gallery.errors, status: :unprocessable_entity
        end
    end

    # 팔로우 리스트 동기화
    # PATCH/PUT /user_galleries/0
    def update
        if params[:id].to_i != 0
            @user_gallery = UserGallery.find(params[:id])

            if @user_gallery.update(user_gallery_params)
                render json: @user_gallery
            else
                render json: @user_gallery.errors, status: :unprocessable_entity
            end
        else
            # 동기화 프로세스
            @user = User.find(params[:user_id])
            @requested_user_galleries = UserGallery.where(id: params[:ids])
            arr = []
            @requested_user_galleries.each do |req|
                somebody = req.user
                gallery = req.gallery

                if @user.id != somebody.id
                    res = UserGallery.create(user: @user, gallery: gallery)
                else
                    res = req
                end
                arr << res
            end
            render json: arr
        end
    end

    # DELETE /user_galleries/1
    # POST /user_galleries/delete(?user_gallery[])
    def destroy
        pa = params[:user_gallery]
        @user_gallery = UserGallery.where(user_id: pa[:user_id], gallery_id: pa[:gallery_id])
        deleted_list = @user_gallery.destroy_all
        render json: deleted_list
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    # No Usage
    def set_user_gallery
        @user_gallery = UserGallery.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_gallery_params
        params.require(:user_gallery).permit(:user_id, :gallery_id)
    end
end
