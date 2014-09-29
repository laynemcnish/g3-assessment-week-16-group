require 'CSV'

class CSVParser

  def initialize(file_path)
    @file_path = file_path
  end

  def read_file
    CSV.read(@file_path, {
      :col_sep => "\t",
      :write_headers => true,
      :headers => ["time", "container", "ph", "nutrient_level", "temperature", "water_level"]
    })
  end

  def return_formatted_file
    read_file.map do |row|
      {
        time: Time.parse(row["time"]),
        container: row["container"],
        ph: row["ph"].to_f,
        nutrient_level: row["nutrient_level"].to_f,
        temperature: row["temperature"].to_f,
        water_level: row["water_level"].to_f
      }
    end
  end
end

# csv = CSVParser.new('/Users/laynemcnish/gSchoolWork/g3-assessement-week-16-group/g3-assessment-week-16/data/metrics.tsv')
#
# csv.return_formatted_file

