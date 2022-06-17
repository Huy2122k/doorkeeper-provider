# frozen_string_literal: true

module Api::V1
  class PostsController < ApiController
    before_action -> { doorkeeper_authorize! :read }, only: %i[index show]
    before_action -> { doorkeeper_authorize! :write }, only: %i[create update destroy]

    def index
      render json: current_resource_owner.posts
    end

    def show
      render json: current_resource_owner.posts.find(params[:id])
    end

    def create
      @post = current_resource_owner.posts.new(post_params)

      if @post.save
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      @post = current_resource_owner.posts.find(params[:id])
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      render :ok
    end

    private
      def post_params
        params.require(:post).permit(:name, :url)
      end
  end
end
