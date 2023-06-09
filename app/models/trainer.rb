class Trainer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :favorites, dependent: :destroy, inverse_of: :trainer

  def initials
    name.split.map { |n| n[0] }.join.upcase
  end
end
