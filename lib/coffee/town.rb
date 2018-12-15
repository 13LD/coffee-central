require 'coffee/result'

module Coffee
  module Central
    class Town
      attr_accessor :width, :height, :town_square

      COFFEE_SHOP = 1

      def initialize(dx:, dy:, x:, y:)
        @width = dx
        @height = dy
        @town_square = Array.new(@height){ Array.new(@width) }

        create_town_square(x, y)
      end

      def get_output_result(max_distance)
        results = this.get_result(max_distance)
        output = ''

        results.each do |result|
          output += result.print + '\n'
        end

        output
      end

      def get_result(max_distance)
        result = []
        for k in 0..max_distance.length
          max_coffee_shop_count = 0
          x = 0
          y = 0

          for i in 0..height
            for j in 0..width
              next if town_square[i][j] == COFFEE_SHOP

              coffee_shop_count = count_coffee_shops(j, i, max_distance[k])

              if coffee_shop_count > max_coffee_shop_count
                max_coffee_shop_count = coffee_shop_count
                x = j
                y = i
              end
            end
          end

          result.append(
            Result.new(
              x: x + 1,
              y: y + 1,
              max_coffee_shops_amount: max_coffee_shop_count
            )
          )
        end

        result
      end

      def count_coffee_shops(x, y, max_distance)
        result = 0
        for i in 0..height
          for j in 0..width
            next unless town_square[i][j] == COFFEE_SHOP && calculate_distance(x1: x, y1: y, x2: j, y2: i) <= max_distance

            result += 1
          end
        end
        result
      end

      def calculate_distance (x1:, y1:, x2:, y2:)
        Math.abs(x1 - x2) + Math.abs(y1 - y2)
      end

      private

      def create_town_square(x, y)
        x.length.times do |index|
          @town_square[y[index] - 1][x[index] - 1] = COFFEE_SHOP
        end
      end
    end
  end
end
