module Cars
  class FetchDb
    # Fetch cars considering the applied filters
    def self.fetch_cars(filters, start_date, end_date)
      query = ActiveRecord::Base.__send__(
        :sanitize_sql,
        "SELECT * FROM cars
        WHERE #{available_from_clause(start_date, end_date)}
        ORDER BY cars.monthly ASC"
      ).delete("\n")

      Car.find_by_sql(query)
    end

    def self.available_from_clause(start_date, end_date)
      "cars.available_from BETWEEN '#{start_date}' AND '#{end_date}'"
    end
  end
end
