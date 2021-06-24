class LikesController < ApplicationController
  include ApplicationHelper

  def create
    type = type_subject?(params)[0] # This function gets the type param of the array [1]
    @subject = type_subject?(params)[1] # This function gets the type param of the array [2]

    return unless @subject

    if already_liked?(type)
      dislike(type)
      flash[:notice] = 'You have Disliked the opinion'
    else
      @like = @subject.likes.build(user_id: current_user.id)
      if @like.save
        flash[:notice] = 'You liked this Opinion'
      else
        flash[:alert] = "#{type} like failed!"
      end
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def type_subject?(params)
    type = 'opinion' if params.key?('opinion_id')
    type = 'comment' if params.key?('comment_id')
    subject = Opinion.find(params[:opinion_id]) if type == 'opinion'
    subject = Comment.find(params[:comment_id]) if type == 'comment'
    [type, subject]
  end

  def already_liked?(type)
    result = false
    if type == 'opinion'
      result = Like.where(user_id: current_user.id,
                          opinion_id: params[:opinion_id]).exists?
    end
    if type == 'comment'
      result = Like.where(user_id: current_user.id,
                          comment_id: params[:comment_id]).exists?
    end
    result
  end

  def dislike(type)
    @like = Like.find_by(opinion_id: params[:opinion_id]) if type ==
                                                             'opinion'
    @like = Like.find_by(comment_id: params[:comment_id]) if type ==
                                                             'comment'
    return unless @like

    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
