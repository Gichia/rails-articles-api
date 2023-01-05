module Api
  module V1
    # Articles controller class to manage articles
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC')
        render json: { status: 'SUCCESS', message: 'Articles loaded', data: articles }, status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: { status: 'SUCCESS', message: 'Article loaded', data: article }, status: :ok
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

      def destroy
        article = Article.find(params[:id])
        article.destroy

        render json: { status: 'SUCCESS', message: 'Article deleted' }, status: :ok
      end

      private

      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :body)
      end
    end
  end
end
