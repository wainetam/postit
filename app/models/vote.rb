class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  # validate :one_vote_per_user

end