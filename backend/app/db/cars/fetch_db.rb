module Cars
  class FetchDb
    # Fetch cars considering the applied filters
    def self.fetch_cars(maker_id, color_id, start_date, end_date)
      query = ActiveRecord::Base.__send__(
        :sanitize_sql,
        "SELECT * FROM cars
        WHERE #{available_from_clause(start_date, end_date)}
        #{maker_clause_if_present(maker_id)}
        #{color_clause_if_present(color_id)}
        ORDER BY cars.monthly ASC"
      ).delete("\n")

      Car.find_by_sql(query)
    end

    def self.available_from_clause(start_date, end_date)
      "cars.available_from BETWEEN '#{start_date}' AND '#{end_date}'"
    end

    def self.maker_clause_if_present(maker_id)
      return unless maker_id.present?

      "AND cars.maker_id = #{maker_id}"
    end

    def self.color_clause_if_present(color_id)
      return unless color_id.present?

      "AND cars.color_id = #{color_id}"
    end
  end
end
