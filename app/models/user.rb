class User < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author?(work)
    work.user_id == id
  end
end
