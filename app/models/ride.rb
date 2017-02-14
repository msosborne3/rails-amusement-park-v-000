class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if !tall_enough? && enough_tickets?
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    elsif tall_enough? && !enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif !tall_enough? && !enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    else
      begin_ride
    end
  end

  def tall_enough?
    if self.user.height > self.attraction.min_height
      true
    else
      false
    end
  end

  def enough_tickets?
    if self.user.tickets >= self.attraction.tickets
      true
    else
      false
    end
  end

  def begin_ride
    updated_happy = self.user.happiness + self.attraction.happiness_rating
    updated_nausea = self.user.nausea + self.attraction.nausea_rating
    updated_tickets = self.user.tickets - self.attraction.tickets
    self.user.update(
      happiness: updated_happy,
      nausea: updated_nausea,
      tickets: updated_tickets
      )

    "Thanks for riding the #{self.attraction.name}!"
  end

end
