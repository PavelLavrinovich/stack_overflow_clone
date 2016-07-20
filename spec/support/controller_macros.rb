module ControllerMacros
  def sign_in_user
    block_given? ? yield : before { @user = create(:user) }
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end
end