class TodoList < ActiveRecord::Base
  validates :title, presence: true
  validates :title, length: { minimum: 4 }
  validates :description, presence: true
  validates :description, length: { minimum: 4 }
end
