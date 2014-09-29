describe CSVParser do

  before { @data = CSVParser.new('data/metrics.tsv').return_formatted_file }

  it "returns the correct data and formats" do
    expect(@data).to be_instance_of(Array)
    expect(@data.first.fetch(:time)).to be_instance_of(Time)
    expect(@data.first.fetch(:container)).to be_instance_of(String)
    expect(@data.first.fetch(:ph)).to be_instance_of(Float)
    expect(@data.first.fetch(:nutrient_level)).to be_instance_of(Float)
    expect(@data.first.fetch(:temperature)).to be_instance_of(Float)
    expect(@data.first.fetch(:water_level)).to be_instance_of(Float)
  end

end