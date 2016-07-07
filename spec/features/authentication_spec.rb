require 'features/feature_helper'

describe 'Authentication', type: :feature do
  before do
    setup_user
  end

  it 'signs up' do
    sign_up_user(email: 'fake_user2@gmail.com', password: 'password2')
    expect(User.count).to equal(2)
  end

  it 'logs in' do
    sign_in
    expect(find('#auth')).to have_content 'Sign Out'
  end

  it 'logs out' do
    sign_in
    sign_out
    expect(find('#auth')).to have_content 'Sign In'
  end

  def setup_user
    Clearance.configuration.user_model.new(email: 'fake_user1@gmail.com', password: 'password1')
  end

  def sign_up_user(email:, password:)
    visit '/sign_up'
    within '.sign-up' do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_on 'Sign Up'
    end
  end

  def sign_in
    visit '/sign_in'
    within '.sign-in' do
      fill_in 'Email', with: 'fake_user1@gmail.com'
      fill_in 'Password', with: 'password1'
      click_on 'Sign In'
    end
  end


  def sign_out
    within '#auth' do
      click_link 'Sign Out'
    end
  end
end
