# encoding: UTF-8
class Consumer < ActiveRecord::Base

  has_many :profiles, dependent: :destroy

end 