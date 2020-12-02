class Journey
  attr_reader :journey

  def initialize
    @journey = {}
    @in_journey = false
  end

  def start_journey(station)
    return @journey[:exit_station] = "incomplete journey" unless !in_journey?
    @in_journey = true
    @journey[:entry_station] = station
  end

  def in_journey?
    @in_journey
  end

  def end_journey(station)
    return @journey[:entry_station] = "incomplete journey" unless in_journey?
    @in_journey = false
    @journey[:exit_station] = station
  end

  def calculate_fair
    return @journey[:fair] = Oystercard::PENALTY_FAIR unless @journey.has_value?("incomplete journey") == false
    @journey[:fair] = Oystercard::MINIMUM_AMOUNT
  end
end
