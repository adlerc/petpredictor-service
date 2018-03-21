class RawStat < ApplicationRecord
  validates :height, :weight, :dog_count, :cat_count, presence: true

end
