module Cars
  class FetchDb
    # Fetch cars considering the applied filters
    SORT_OPTIONS = %w[montly year maker_name available_from].freeze
    ORDER_OPTIONS = %w[asc desc].freeze

    def self.fetch_cars(filters)
      query = ActiveRecord::Base.__send__(
        :sanitize_sql,
        "SELECT cars.* FROM cars
        #{join_with_maker_if_sort_by_them(filters[:sort])}
        WHERE #{available_from_clause(filters[:start_date], filters[:end_date])}
        #{maker_clause_if_present(filters[:maker_id])}
        #{color_clause_if_present(filters[:color_id])}
        #{order_by_clause(filters[:sort], filters[:sort_order])}
        #{pagination_clause_if_present(filters[:limit], filters[:offset])}"
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

    def self.pagination_clause_if_present(limit, offset)
      return unless limit.present? && offset.present?

      "LIMIT #{limit}
      OFFSET #{offset}"
    end

    def self.order_by_clause(sort, order)
      sort = 'monthly' if sort.blank? || !SORT_OPTIONS.include?(sort)
      order = 'ASC' if order.blank? || !ORDER_OPTIONS.include?(order)

      if sort == 'maker_name'
        "ORDER BY makers.name #{order}"
      else
        "ORDER BY cars.#{sort} #{order}"
      end
    end

    def self.join_with_maker_if_sort_by_them(sort)
      return if sort != 'maker_name'

      'INNER JOIN makers ON makers.id = cars.maker_id'
    end
  end
end
