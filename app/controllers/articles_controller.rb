class ArticlesController < ApplicationController
  skip_before_action :authoraize_request, only: :show

  def create
    # ここでarticleクラスがuser_idを参照しようとしている？
    # referencesにしていないがuser_idを追加
    @article = @current_user.articles.new(article_params)

    if @article.save
      render_article(@article.user)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.find_by(slug: params[:slug])
    # 関連付けしているのにuserがundefined method for nil:NilClass
    render_article(@article.user)
  end

  def update
    @article = Article.find_by(slug: params[:slug])

    if @article.update(article_params)
      render_article(@article.user)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find_by(slug: params[:slug])
  end

  private

    # createとupdateでjsonを返す
    def render_article(user = nil)
      render json: { article: @article.to_json(user) }
    end

    def article_params
      params.require(:article).permit(:title, :description, :body)
    end
end
