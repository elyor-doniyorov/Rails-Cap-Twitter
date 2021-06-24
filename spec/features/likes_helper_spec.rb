require 'rails_helper'

feature 'User likes an opinion' do
  let(:user) do
    User.create(fullname: 'elyor doniyorov', username: 'test1', email: 'test11@gmail.com', password: '123456')
  end

  scenario 'liking an opinion' do
    visit root_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    visit root_path
    fill_in 'text', with: 'Testing post'
    click_button 'Tweet'
    page.first('#like').click
    expect(page).to have_text('You liked this Opinion')
  end

  scenario 'Disliking an opinion' do
    visit root_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    visit root_path
    fill_in 'text', with: 'Testing post'
    click_button 'Tweet'
    page.first('#like').click
    page.first('#like').click
    expect(page).to_not have_text('You have Disliked the opinion')
  end
end
