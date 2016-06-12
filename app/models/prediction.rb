class Prediction < ActiveRecord::Base
  belongs_to :match
  belongs_to :user

  validate :validate_match

  def validate_match
    errors.add(:match, ' started !!!') if match.started? && !ENV["SKIP_VALIDATION"]
  end

  def locked?
    match.started?
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
