class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  def win?
    (match.mainscore1 == mainscore1) && (match.mainscore2 == mainscore2)
  end

  def subwin?
    win? ? false : 
      ( ((match.mainscore1 == match.mainscore2) && (mainscore1 == mainscore2)) ||
        ((match.mainscore1 >  match.mainscore2) && (mainscore1 >  mainscore2)) ||
        ((match.mainscore1 <  match.mainscore2) && (mainscore1 <  mainscore2)) )
  end
end
