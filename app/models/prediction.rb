class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :user
  belongs_to :cup

  validate :validate_match

  validates :match_id, uniqueness: { scope: :user_id, message: "one prediction per match for each user" }

  after_save :update_score

  def update_score
    Score.find_or_create_by(user: user, cup: cup)
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

  def reward
    win? ? (cup.reward_percent*cup.match_fee*match.valid_users_count/match.prediction_winners_count).round : 0
  end
end
