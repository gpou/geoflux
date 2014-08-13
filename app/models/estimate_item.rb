class EstimateItem < ActiveRecord::Base
  belongs_to :estimateable, :polymorphic => true
end