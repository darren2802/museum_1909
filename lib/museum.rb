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
    @exhibits.find_all { |exhibit| patron.interests.include?(exhibit.name) }
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
    @exhibits.reduce({}) do |acc, exhibit|
      patrons_with_interest = @patrons.find_all { |patron| patron.interests.include?(exhibit.name) }
      acc[exhibit] = patrons_with_interest
      acc
    end
  end

  def patrons_of_exhibits
    @patrons_of_exhibits
  end

end
