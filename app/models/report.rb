class Report < ApplicationRecord
  self.abstract_class = true
  # connects_to database: { reading: :sendit }
  establish_connection :sendit
end