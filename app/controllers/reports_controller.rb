class ReportsController < ApplicationController
  before_action :fetch_data, only: [:show, :export]

  def show
    if !@data_present
      render :new and return
    end
  end

  def export
    if !@data_present
      redirect_to new_report_path, alert: 'Startdatum und Enddatum sind erforderlich!' and return
    end
  
    respond_to do |format|
      format.xlsx {
        today = Date.today.strftime('%d%m%Y')
        filename = "Export_#{today}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      }
    end
  end
  
  
  private

  def fetch_data
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.blank? || end_date.blank?
      @results = []
      flash[:alert] = 'Startdatum und Enddatum sind erforderlich!'
      return
      else
      @data_present = true
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

      all_results = Report.connection.exec_query(ActiveRecord::Base.sanitize_sql_array([sql_query, formatted_start_date, formatted_end_date]))
      @results = Kaminari.paginate_array(all_results.to_a).page(params[:page]).per(50)
    end
  end
end
