require 'rails_helper'
RSpec.describe 'the following process', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(fullname: 'elyor doniyorov', username: 'test1', email: 'test11@gmail.com', password: '123456')
  end
  let(:user2) do
    User.create(fullname: 'maftuna doniyorova', username: 'test2', email: 'test11@gmail.com', password: '123456')
  end

  it 'Send a follow request to other users' do
    visit root_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'Log in'
    visit user2.id
    expect(page).to_not have_link(href: '/follow_user/1')
  end
end
