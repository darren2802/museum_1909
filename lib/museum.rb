class Museum

  attr_reader :name, :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommend = []
    @exhibits.each do |exhibit|
      recommend << exhibit if patron.interests.any? { |interest| interest == exhibit.name }
    end
    recommend
  end

end
