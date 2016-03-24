class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy
  belongs_to :user
  default_scope { order('created_at DESC') }
  # checkpoint-39 assignment code
  scope :ordered_by_title, -> {order('title ASC')}
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
end
