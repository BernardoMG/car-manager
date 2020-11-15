module Cars
  class Collector
    DATE_FORMAT = '%Y-%m-%d'.freeze

    attr_reader :filters, :maker_id, :color_id

    def initialize(filters)
      @filters = filters
      @maker_id = filters[:maker_id]
      @color_id = filters[:color_id]
    end

    def self.run(filters)
      new(filters).run
    end

    def run
      start_date = current_date
      cars = Cars::FetchDb.fetch_cars(
        maker_id,
        color_id,
        start_date,
        end_date
      )

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
