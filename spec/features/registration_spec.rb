require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: 'password123', password_confirmation: 'password123')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it 'does not create a user if passwords dont match' do

    visit register_path

    expect(User.count).to eq(1)

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with: 'thisisanemail@email.com'
    fill_in :user_password,	with: 'thispassworddoesnotmatch123'
    fill_in :user_password_confirmation, with: 'thispassisdifferent123'
    click_button 'Create New User'

    expect(User.count).to eq(1)
    expect(page).to have_content("Passwords don't match. Are you sure you typed that correctly?")
  end
end
