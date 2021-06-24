class OpinionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @opinion = Opinion.new
    @current = current_user.not_following
  end

  def new
    @opinion = Opinion.new
  end

  def create
    @opinion = Opinion.new(opinions_params)
    @opinion.author_id = current_user.id

    if @opinion.save
      current_user.opinion_count += 1
      current_user.save
      redirect_to root_path
    else
      flash[:alert] = 'Please fill some characters'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @opinion = Opinion.find(params[:id])
  end

  def destroy; end

  private

  def opinions_params
    params.require(:opinion).permit(:text)
  end
end
