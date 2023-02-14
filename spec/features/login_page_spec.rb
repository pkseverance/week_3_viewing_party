RSpec.describe 'User login page' do
    it 'has a login form where I can input my unique email and password' do
        User.create(name: 'Name', email: 'email@email.com', password: 'pass123')
        visit '/login'

        fill_in :email, with: 'email@email.com'
        fill_in :password, with: 'pass123'
        click_button 'Login'

        expect(current_path).to eq(user_path(User.last.id))
    end
end
