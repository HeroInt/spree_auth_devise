require 'spec_helper'

feature 'Admin - Sign Out' do
  given!(:user) do
   create(:user,
          email: 'email@person.com',
          password: 'secret',
          password_confirmation: 'secret')
  end

  background do
    visit spree.admin_login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    # Regression test for #1257
    check 'Remember me'
    click_button 'Login'
  end

  scenario 'allow a signed in user to logout' do
    click_link 'Logout'
    visit spree.admin_login_path
    expect(page).to have_text 'Admin login'
    expect(page).not_to have_text 'Logout'
  end
end
