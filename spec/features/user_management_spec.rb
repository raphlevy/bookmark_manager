require 'byebug'

feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = build :user
    expect { sign_up user }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{user.email}")
    expect(User.first.email).to eq("#{user.email}")
  end

  scenario 'with a password that does not match' do
    user = build(:user, password_confirmation: "hellooo")
    expect { sign_up user}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  # scenario 'count unchanged when user does not enter an email'do
  #   expect { sign_up(email: '')}.not_to change(User, :count)
  # end

  scenario 'error message displayed when user does not enter an email' do
    user = build(:user, email: "")
    expect { sign_up user }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    # expect(page).to have_content 'You must enter an email to sign up'
  end

  scenario 'I cannot sign up with an existing email' do
    user = build :user
    sign_up user
    expect { sign_up user }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

  # def sign_up user
  #   visit '/users/new'
  #   fill_in :email, with: user.email
  #   fill_in :password, with: user.password
  #   fill_in :password_confirmation, with: user.password_confirmation
  #   click_button 'Sign up'
  # end

end

feature 'User sign in' do

  scenario 'with correct credentials' do
    user = create(:user)
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  # def sign_in(email:, password:)
  #   visit'/sessions/new'
  #   fill_in :email, with: email
  #   fill_in :password, with: password
  #   click_button 'Sign in'
  # end

end

feature 'User signs out' do

  let!(:user) { FactoryGirl.create(:user) }

  # before(:each)do
  #   user = FactoryGirl.create(:user)
  # end

  scenario 'while being signed in' do
    sign_in(email: user.email, password: user.password)
    click_button 'Sign out'
    expect(page).to have_content('You are now logged out')
    expect(page).not_to have_content("Welcome, #{user.email}")
  end

end