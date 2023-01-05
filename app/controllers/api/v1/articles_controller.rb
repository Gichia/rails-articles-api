module Api
  module V1
    # Articles controller class to manage articles
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC')
        render json: { status: 'SUCCESS', data: articles }, status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: { status: 'SUCCESS', data: article }, status: :ok
      end
    end
  end
end
