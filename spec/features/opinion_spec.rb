require 'rails_helper'

feature 'User login the app' do
  let(:user) do
    User.create(fullname: 'elyor doniyorov', username: 'test1', email: 'test11@gmail.com', password: '123456')
  end

  scenario 'Posting opinion' do
    visit root_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    visit root_path
    fill_in 'text', with: 'Testing post'
    expect(page).to_not have_text("elyor doniyorov\n0\nFollowing\n0\nFollowers\nhome HOME\nperson PROFILE\nperson\ncreate local_post_office search settings\nWhat's Happening?\nNEW OPINIONS\nWHO TO FOLLOW")
  end
end
