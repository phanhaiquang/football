class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { order(:id) }

  has_many :predictions

  def name
    email.gsub(/@.*/, '')
  end

  def update_score
    score = 0
    self.predictions.each do |prediction|
      score += prediction.win?    ? 2 :
               prediction.subwin? ? 1 : 0
    end
    update_attributes(score: score)
  end
end
