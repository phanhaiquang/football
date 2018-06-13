class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :predictions
  has_many :matches, through: :predictions

  def name
    email.gsub(/@.*/, '')
  end
  
  def get_score(cup_id_a)
    (Score.where("user_id = ? AND cup_id = ?", self, cup_id_a).count == 0)? 0 : Score.where("user_id = ? AND cup_id = ?", self, cup_id_a).first.score 
  end
end
