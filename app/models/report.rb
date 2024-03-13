class Report < ApplicationRecord
  self.abstract_class = true
  establish_connection :sendit
end