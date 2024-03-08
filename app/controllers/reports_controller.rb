class ReportsController < ApplicationController
    before_action :require_login
  
    def new
      # This action renders the form.
    end
  
    def create
      # Assuming start_date and end_date are passed as 'YYYY-MM-DD'
      start_date = params[:start_date]
      end_date = params[:end_date]
  
      # Sanitize inputs to prevent SQL injection
      formattedStartDate = ActiveRecord::Base.connection.quote(start_date)
      formattedEndDate = ActiveRecord::Base.connection.quote(end_date)
  
      # Since you're executing a raw SQL query, you might not need to use Report.connection.
      # Instead, you can establish a direct connection to your SendIT database like so:
      sendit_connection = ActiveRecord::Base.establish_connection(:sendit).connection
  
      sql_query = "SELECT DISTINCT 
                      [ShippingDate], 
                      [CustomerAccountNr], 
                      [CustomerOrderNr], 
                      [OrderNr], 
                      [InvoiceNr], 
                      [DeliveryNoteNr] 
                      FROM [SendIT].[Printed] 
                      WHERE Shipper = 'Dachser' AND ShippingDate BETWEEN #{formattedStartDate} AND #{formattedEndDate} ORDER BY ShippingDate ASC"
      @results = sendit_connection.exec_query(sql_query)
  
      # Ensure to dispose the connection after use to avoid exhaustion of the pool
      sendit_connection.disconnect!
  
      # Assuming you want to render 'show' view to display these results
      render :show
    end
end
  