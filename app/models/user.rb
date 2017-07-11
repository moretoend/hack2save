class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_jobs
  has_many :jobs, through: :user_jobs
  has_many :reviews, as: :reviewable

  has_many :institution_users
  has_many :institutions, through: :institution_users
  has_many :complaints, as: :denunciable
end
