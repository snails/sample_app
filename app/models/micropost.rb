class Micropost < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content

  validates  :content, :length => {:minmum => 1, :maximum => 140}
end
