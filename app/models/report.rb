class Report < ApplicationRecord
  self.abstract_class = true
  self.table_name = 'SendIT.Printed'
  connects_to database: { reading: :sendit }
end
