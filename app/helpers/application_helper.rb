module ApplicationHelper
  # liked? can be used to differentiate buttons on the view by knowing in wich stage it is
  def liked?(subject, type)
    result = false
    if type == 'opinion'
      result = Like.where(user_id: current_user.id, opinion_id:
                          subject.id).exists?
    end
    if type == 'comment'
      result = Like.where(user_id: current_user.id, comment_id:
                          subject.id).exists?
    end
    result
  end

  def notice?
    return unless notice.present?

    content_tag(:div, class: 'notice notifications') do
      content_tag(:p, notice)
    end
  end

  def alert?
    return unless alert.present?

    content_tag(:div, class: 'notice notifications') do
      content_tag(:p, alert)
    end
  end

  def different_user(subject)
    Like.where(user_id: current_user.id, opinion_id: subject.id).exists?
  end

  def dynamic_like(subject, type)
    if liked?(subject, type)
      content_tag :p, id: 'like' do
        'You liked this comment'
      end
    else
      button_to opinion_likes_path(subject), class: 'text-light card-link', method: :post, id: 'like' do
        content_tag :span, class: 'text-dark mt-2 mb-2' do
          content_tag :strong do
            'Like'
          end
        end
      end
    end
  end

  def who_to_follow(following)
    render 'opinions/following', f: following if current_user != following && !current_user.already_follow?(following)
  end
end
