require 'data_selector'
class Calculator

  def initialize(data)
    @data = data
  end

  def data_selector
    DataSelector.new(CSVParser.new('data/metrics.tsv').return_formatted_file)
  end

  def find_averages(container)
    container.each_with_object({}) do |row, new_hash|
      new_hash[:container] = row[:container]
      new_hash[:ph] = average(choose_key(container, :ph))
      new_hash[:nutrient_level] = average(choose_key(container, :nutrient_level))
      new_hash[:temperature] = average(choose_key(container, :temperature))
      new_hash[:water_level] = average(choose_key(container, :water_level))
    end
  end

  def find_highest_average(symbol)
    array = []
    array << find_averages(data_selector.container1)
    array << find_averages(data_selector.container2)
    array << find_averages(data_selector.container3)
    array.max_by { |avg_hash| avg_hash[symbol]}.fetch(:container)
  end

  def find_highest_for_type(symbol)
    data_selector.all_data.max_by { |avg_hash| avg_hash[symbol] }.fetch(:container)
  end

  def find_highest_time_delimited(symbol, start_date, end_date)
    data = data_selector.all_data.reject { |hashes| hashes[:time] < start_date || hashes[:time] > end_date}
    data.max_by { |avg_hash| avg_hash[symbol] }.fetch(:container)
  end

  def average(array)
    total = array.inject(:+)
    (total / array.length).round(2)
  end

  def choose_key(container, key)
    container.collect { |row| row[key] }
  end
end