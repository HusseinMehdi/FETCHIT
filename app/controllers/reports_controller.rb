class ReportsController < ApplicationController
    before_action :require_login, only: [:new, :show]

    def new

    end

    def edit
        
    end

    def show
        start_date = params[:start_date]
        end_date = params[:end_date]
    
        # Ensure dates are present
        if start_date.blank? || end_date.blank?
          @results = []
          flash.now[:alert] = 'Start date and end date are required.'
          render :new and return
        end
    
        formatted_start_date = DateTime.parse(start_date).strftime('%Y%m%d')
        formatted_end_date = DateTime.parse(end_date).strftime('%Y%m%d')
    
        sql_query = <<-SQL
          SELECT DISTINCT
            [ShippingDate],
            [CustomerAccountNr],
            [CustomerOrderNr],
            [OrderNr],
            [InvoiceNr],
            [DeliveryNoteNr]
          FROM
            SendIT.Printed
          WHERE
            Shipper = 'Dachser' AND
            CONVERT(INT, REPLACE(CONVERT(VARCHAR, ShippingDate, 102), '.', '')) BETWEEN ? AND ?
          ORDER BY
            ShippingDate ASC
        SQL
        @results = Report.connection.exec_query(ActiveRecord::Base.sanitize_sql_array([sql_query, formatted_start_date, formatted_end_date]))
    end
end
  