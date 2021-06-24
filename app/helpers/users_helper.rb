module UsersHelper
  def user_session
    return render 'layouts/header' if user_signed_in?
  end

  def picture_for(user)
    if user[:background_image].nil?
      content_tag(:img, '', src: 'https://source.unsplash.com/800x200', alt: user.fullname, class: 'cover-img')
    else
      content_tag(:img, '', src: user.background_image, alt: @user.fullname, class: 'cover-img')
    end
  end

  def user_follow_enabled?
    if !current_user.already_follow?(@user.id) && @user.id != current_user.id
      link_to follow_user_path(@user.id) do
        content_tag :span, class: 'material-icons' do
          content_tag :i, class: 'material-icons material-icons-special' do
            'add_circle_outline'
          end
        end
      end
    else
      content_tag :span, class: 'material-icons', style: 'color: #376e9a' do
        'add_circle_outline'
      end
    end
  end

  def user_follow_button?
    link_to follow_user_path(@user.id) do
      content_tag :span, class: 'material-icons' do
        content_tag :i, class: 'material-icons material-icons-special' do
          'add_circle_outline'
        end
      end
    end
  end
end
