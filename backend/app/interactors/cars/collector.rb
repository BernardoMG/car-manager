module Cars
  class Collector
    DATE_FORMAT = '%Y-%m-%d'.freeze
    ITEMS_PER_PAGE = 20

    attr_reader :filters, :maker_id, :color_id, :page

    def initialize(filters)
      @filters = filters.clone
      @page = filters[:page].to_i
    end

    def self.run(filters)
      new(filters).run
    end

    def run
      filters[:start_date] = current_date
      filters[:end_date] = end_date

      if page.present? && page.positive?
        filters[:limit] = ITEMS_PER_PAGE
        filters[:offset] = (ITEMS_PER_PAGE * (page - 1))
      end

      cars = Cars::FetchDb.fetch_cars(filters)
      cars.as_json
    end

    private

    def current_date
      Date.today.strftime(DATE_FORMAT)
    end

    # We want to filter cars with an available from bigger than three months in the future.
    def end_date
      (Date.today + 3.months).strftime(DATE_FORMAT)
    end
  end
end
