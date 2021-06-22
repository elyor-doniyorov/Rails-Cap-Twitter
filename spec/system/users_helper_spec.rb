require 'rails_helper'

RSpec.describe 'the signin process', type: :system do
  before do
    driven_by(:rack_test)
  end
  it 'Signs in' do
    user1 = User.create(fullname: 'ngani1', username: 'test1', email: 'test_user1@email.com', password: '123456')
    visit root_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'Log in'
    # visit users_path
    expect(page).to have_text('Signed in successfully.')
  end

  it 'Signs_up withouth photo or background' do
    visit new_user_registration_path
    fill_in 'user[fullname]', with: 'Andrea Testing'
    fill_in 'user[username]', with: 'Andreatesting21'
    fill_in 'user[email]', with: 'andreatesting@gmail.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign up'
    # visit users_path
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  it 'Signs_up with username already taken data' do
    User.create(fullname: 'ngani1', username: 'test1', email: 'test_user1@email.com', password: '123456')
    visit new_user_registration_path
    fill_in 'user[fullname]', with: 'ngani2'
    fill_in 'user[username]', with: 'test1'
    fill_in 'user[email]', with: 'test_user11@email.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    # find('input[id="user_photo"]').click
    click_button 'Sign up'
    expect(page).to have_text('1 error prohibited this user from being saved:')
  end

  it 'Signs_up with email already taken data' do
    User.create(fullname: 'ngani1', username: 'test1', email: 'test_user1@email.com', password: '123456')
    visit new_user_registration_path
    fill_in 'user[fullname]', with: 'ngani2'
    fill_in 'user[username]', with: 'test2'
    fill_in 'user[email]', with: 'test_user1@email.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    # find('input[id="user_photo"]').click
    click_button 'Sign up'
    expect(page).to have_text('1 error prohibited this user from being saved:')
  end
end
