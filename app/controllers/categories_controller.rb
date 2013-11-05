class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Your category #{@category.name} was created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by_name(params[:name])
  end

  private

  def category_params
    params.require(:category).permit!
  end

end
