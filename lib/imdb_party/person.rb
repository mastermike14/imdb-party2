module ImdbParty
  class Person
    attr_accessor :name, :nconst, :bio, :birthdate, :birthplace, :deathdate, :deathcause, :deathplace, :known_for
    
    def initialize(options={})
      @name = options["name"]
      @nconst = options["nconst"]
      @bio = options["bio"] if options['bio']
      if options['birth']
      @birthplace = options['birth']['place']
      @birthdate = options['birth']['date']['normal']
      end
      if options["death"]
        @deathdate= options["death"]["date"]["normal"].to_s
        @deathcause = options["death"]["cause"]
        @deathplace = options["death"]["place"]
      end


      @known_for = options["known_for"] if options['known_for']




    end
    
  end
end
