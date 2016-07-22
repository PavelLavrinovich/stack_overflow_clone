require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many :questions }
  it { should have_many :answers }

  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe 'author?' do
    it 'returns true for authors' do
      question.user = user
      expect(user.author?(question)).to eq true
    end

    it 'returns false for another users' do
      expect(another_user.author?(question)).to eq false
    end
  end

end