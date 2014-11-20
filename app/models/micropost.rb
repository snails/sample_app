class Micropost < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content

  validates  :content, :length => {:minmum => 1, :maxmum => 140}
end
