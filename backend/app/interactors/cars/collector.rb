module Cars
  class Collector
    # attr_reader :filters

    def initialize(filters)
      # @filters = params[:filters]
    end

    def self.run(filters)
      new(filters).run
    end

    def run
      # invoices = selected_invoices_query
      # generate_response(invoices)
    end
  end
end
