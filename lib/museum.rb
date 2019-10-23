class Museum

  attr_reader :name, :exhibits, :patrons, :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
    @patrons_of_exhibits = Hash.new
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

  def admit(patron)
    @patrons << patron
    recommended_exhibits = recommend_exhibits(patron).sort_by { |reco_exhibit| -reco_exhibit.cost }

    recommended_exhibits.each do |exhibit|
      if patron.spending_money >= exhibit.cost
        @revenue += exhibit.cost
        patron.spending_money -= exhibit.cost
        if @patrons_of_exhibits[exhibit]
          @patrons_of_exhibits[exhibit] << patron
        else
          @patrons_of_exhibits[exhibit] = [patron]
        end
      end
    end

  end

  def patrons_by_exhibit_interest

    interests_grouped = Hash.new

    @exhibits.each do |exhibit|
      interests_grouped[exhibit] = []
      @patrons.each do |patron|
        interests_grouped[exhibit] = [] << patron if patron.interests.any? { |interest| interest == exhibit.name }
      end
    end
    interests_grouped
  end

  def patrons_of_exhibits
    @patrons_of_exhibits
  end

end
