module Api
  module V1
    # Articles controller class to manage articles
    class ArticlesController < ApplicationController
      # Set article before the following list of endpoints
      before_action :set_article, only: %i[show update destroy]

      def index
        articles = Article.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Articles loaded', data: articles }, status: :ok
      end

      def show
        render json: { status: 'SUCCESS', message: 'Article loaded', data: @article }, status: :ok
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: { status: 'SUCCESS', message: 'Article saved', data: article }, status: :created
        else
          render json: { status: 'ERROR', message: 'Article not saved!', data: article.errors },
                 status: :unprocessable_entity
        end
      end

      def update
        if @article.update(article_params)
          render json: { status: 'SUCCESS', message: 'Article updated', data: @article }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Article not updated!', data: @article.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @article.destroy
        render json: { status: 'SUCCESS', message: 'Article deleted' }, status: :ok
      end

      private

      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :body)
      end

      # Use variable across multiple endpoints
      def set_article
        @article = Article.find(params[:id])
      end
    end
  end
end
