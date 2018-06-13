class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  validate :validate_match

  #FIXME
  after_save :update_score
  def update_score
    if (Score.where("user_id = ? AND cup_id = ?", self.user_id, self.cup_id).count == 0)
      Score.create(:user_id => user_id, :cup_id => cup_id, :score => 0)
    end
    match.update_score
  end

  def validate_match
    errors.add(:match, ' started !!!') if match.started? && !APP_CONFIG["skip_validation"]
  end

  def locked?
    match.started? && !APP_CONFIG["skip_validation"]
  end

  def open?
    !locked?
  end

  def closed?
    match.closed?
  end

  def score
    win? ? 2 : ( subwin? ? 1 : 0 )
  end

  def mainscores
    "#{mainscore1} - #{mainscore2}"
  end

  def win?
    closed? && ((match.mainscore1 == mainscore1) && (match.mainscore2 == mainscore2))
  end

  def subwin?
    closed? && (win? ? false :
      ( ((match.mainscore1 == match.mainscore2) && (mainscore1 == mainscore2)) ||
        ((match.mainscore1 >  match.mainscore2) && (mainscore1 >  mainscore2)) ||
        ((match.mainscore1 <  match.mainscore2) && (mainscore1 <  mainscore2)) ))
  end
end
