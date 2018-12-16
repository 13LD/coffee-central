require "coffee/central/version"
require 'coffee/result'
require 'coffee/town'

module Coffee
  module Central

    def self.get_result(town_inputs, show_result: true)
      result = []
      result_output = []
      number_of_cases = 1

      town_inputs.each do |town_case|
        @status = true
        town_case_lines = town_case.split("\n")
        params = town_case_lines[0].split(" ")
        dx, dy, n, q = params.map(&:to_i)
        next unless Coffee::Central.is_valid_input_data?(dx, dy, n, q)

        x = Array.new(n)
        y = Array.new(n)
        m = Array.new(q)

        (1..n).each do |i|
          raise(StandardError, 'Invalid input data') if town_case_lines[i].nil?
          params = town_case_lines[i].split(" ")
          x[i - 1], y[i - 1] = params.map(&:to_i)

          unless 1 <= x[i-1] && x[i-1] <= dx && 1 <= y[i-1] && y[i-1] <= dy
            @status = false
            break
          end
        end

        raise(StandardError, 'Invalid input data') unless @status

        (0..q).each do |i|
          params = town_case_lines[i + n + 1].split(" ")
          m[i] = params[0].to_i

          unless 0 <= m[i] && m[i] <= 1000000
            @status = false
            break
          end
        end

        raise(StandardError, 'Invalid input data') unless @status

        town = Town.new(dx: dx, dy: dy, x: x, y: y)
        result.append(town.get_result(m))

        if show_result
          puts "Case #{number_of_cases}:"
          puts "#{town.get_output_result(m)}"
        else
          number_of_cases += 1
        end
        result_output.append(town.get_output_result(m))
      end

      result_output
    end

    def self.get_town_file_input(file_name)
      current_case = ''
      town_inputs = []

      File.open(File.dirname(__FILE__) + file_name, 'r') do |f|
        f.each_line do |line|
            current_case += line
        end

      end

      town_inputs.append(current_case)
      town_inputs
    end

    def self.is_valid_input_data?(dx, dy, n, q)
      status = 1 <= dx && dx <= 1000 && 1 <= dy && dy <= 1000 && 0 <= n && n <= 5105 && 1 <= q && q <= 20
      raise "Invalid input data" unless status

      status
    end

  end
end

# Coffee::Central.get_result(Coffee::Central.get_town_file_input('input1.txt'))
