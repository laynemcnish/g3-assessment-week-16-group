class DataSelector

  def initialize(data)
    @data = data
  end

  def container1
    @data.select{ |row| row[:container] == "container1"}
  end

  def container2
    @data.select{ |row| row[:container] == "container2"}

  end

  def container3
    @data.select{ |row| row[:container] == "container3"}

  end

  def all_data
  @data
  end
end