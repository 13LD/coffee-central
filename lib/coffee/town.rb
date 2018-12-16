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
        square = @town_square.dup

        x.each_index do |index|
          square[y[index] - 1][x[index] - 1] = COFFEE_SHOP
        end
        @town_square =
          square.map do |item|
            item.map do |el|
              el.nil? ? 0 : el
            end
          end
        # puts "#{@town_square}"
      end

      def get_output_result(max_distance)
        results = get_result(max_distance)
        output = ''

        results.each do |result|
          output += result.print_method
        end

        output
      end

      def get_result(max_distance)
        result = []
        max_distance.each_index do |k|
          max_coffee_shop_count = 0
          x = 0
          y = 0

          @town_square.each_index do |i|
            @town_square[i].each_index do |j|
              next if @town_square[i][j] == COFFEE_SHOP

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
        @town_square.each_with_index do |_item, i|
          @town_square[i].each_with_index do |_item, j|
            result += 1 if @town_square[i][j].to_i == COFFEE_SHOP && calculate_distance(x1: x, y1: y, x2: j, y2: i) <= max_distance
          end
        end
        result
      end

      def calculate_distance (x1:, y1:, x2:, y2:)
        (x1 - x2).abs + (y1 - y2).abs
      end
    end
  end
end
