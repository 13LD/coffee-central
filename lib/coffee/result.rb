module Coffee
  module Central
    class Result
      attr_accessor :x, :y, :max_coffee_shops_amount

      def initialize(x:, y:, max_coffee_shops_amount:)
        @x = x
        @y = y
        @max_coffee_shops_amount = max_coffee_shops_amount
      end

      def print
        "#{@max_coffee_shops_amount} (#{@x}, #{@y})"
      end

      def equal?(another)
        if (another.is_a?(Result))
          return @x == another&.x && @y == another&.y &&
                 @max_coffee_shops_amount == another&.max_coffee_shops_amount
        end

        false
      end
    end
  end
end
