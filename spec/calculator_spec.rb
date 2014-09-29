require 'calculator'
require 'time'

describe Calculator do

  before { @data = CSVParser.new('data/metrics.tsv').return_formatted_file }
  before { @calculator = Calculator.new(@data) }
  before { @container1 = @calculator.data_selector.container1 }
  before { @container2 = @calculator.data_selector.container2 }
  before { @container3 = @calculator.data_selector.container3 }
  before { @all_containers = @calculator.data_selector.all_data }
  before { @start_date = Time.parse('2014-01-01 00:24:00 UTC') }
  before { @end_date = Time.parse('2014-01-01 00:36:00 UTC') }

  it 'returns the averages for a dataset' do
    expect(@container1).to be_instance_of(Array)
    expect(@calculator.find_averages(@container1))
    .to eq({:container => 'container1', :ph => 5.01, :nutrient_level => 39.02, :temperature => 57.76, :water_level => 2.12})

    expect(@calculator.find_averages(@container2))
    .to eq({container: 'container2', ph: 5.95, nutrient_level: 19.77, temperature: 73.06, water_level: 3.8})

    expect(@calculator.find_averages(@container3))
    .to eq({container: 'container3', ph: 7.01, nutrient_level: 10.97, temperature: 67.61, water_level: 4.7})
  end

  it 'returns the averages for all data' do
    expect(@calculator.find_averages(@all_containers))
    .to eq({container: 'container3', ph: 5.99, nutrient_level: 23.25, temperature: 66.15, water_level: 3.54})
  end

  it 'returns container with highest average temperature' do
    expect(@calculator.find_highest_average(:temperature))
    .to eq('container2')
  end

  it 'returns container with highest absolute water level' do
    expect(@calculator.find_highest_for_type(:water_level))
    .to eq('container3')
  end

  it 'returns container with highest absolute ph level' do
    expect(@calculator.find_highest_for_type(:ph))
    .to eq('container3')
  end

  it 'returns highest absolute value for type when restricted by time' do
    expect(@calculator.find_highest_time_delimited(:ph, @start_date, @end_date))
    .to eq('container3')
    expect(@calculator.find_highest_time_delimited(:nutrient_level, @start_date, @end_date))
    .to eq('container1')
  end

end