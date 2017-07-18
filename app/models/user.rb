class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions
  has_many :jobs, through: :subscriptions
  has_many :reviews, as: :receiver

  has_many :permissions
  has_many :institutions, through: :permissions
  has_many :complaints, as: :denounced
end
