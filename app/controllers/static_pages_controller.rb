class StaticPagesController < ApplicationController
  include LatestContents
  before_action -> { latest_news(2) }

  def thanks
  end
  def association
  end

  def about
  end

  def faq
  end

  def shop_list
  end

  def privacypolicy
  end

  def recovery_cloth
  end

  def recovery_eye_pillow
  end

  def recovery_multi_wear
  end

  def recovery_room_aroma_mist
  end

  def bathtime_drink
  end

  def products
  end

  def recovery_leg_fit
  end

  def recovery_leggings
  end

  def recovery_long_sleeve_tshirt
  end

  def recovery_short_sleeve_tshirt
  end
end
