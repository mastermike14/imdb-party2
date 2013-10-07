# coding: utf-8
module ImdbParty
  class Imdb
    include HTTParty
    #include HTTParty::Icebox
    #cache :store => 'file', :timeout => 120, :location => Dir.tmpdir
  #TODO: Fix localization
    base_uri 'app.imdb.com'
    #default_params = {"api" => "v1", "appid" => "iphone3", "locale" => "en_US", "timestamp" => Time.now.to_i, "sig" => "app1_1"}
    default_params = {"api" => "v1", "appid" => "iphone1_1", "apiPolicy" => "app1_1", "locale" => "de_DE", "apiKey" => "izhvlfj5zvLM/gWsjLE0/g", "timestamp" => Time.now.to_i}
    def createParameter
      parameter = Hash.new
      parameter['api'] = 'v1'
      parameter['appid'] = "iphone1_1"
      parameter['device'] = ""
      parameter['locale'] = 'de_DE'
      parameter['timestamp'] = Time.now.to_i
      return parameter
    end

  def writeFile(imdb_id, resource, method, json)
  open("#{Rails.root}/json/imdb/#{resource}/#{method}/#{imdb_id}.json", "w+")  { |file| file.write(json) }
  end

    def hello
      arg= Hash.new
      arg['timestamp'] = Time.now
      arg['location'] = 'de_DE'
      arg['count'] = 1
      arg['device_model'] = 'iPhone'
      arg['system_name'] = 'iPhone OS '
      arg['system_version'] = '4.0.1'
      self.class.get('/hello', arg).parsed_response
    end

    def main
      options = { :query => {:tconst => 'tt0068646' } }
      self.class.get('/title/maindetails', options ).parsed_response
    end

     def find_movie_by_id(imdb_id)
      result = self.class.get('/title/maindetails', :query => {:tconst => imdb_id}).parsed_response
      writeFile(imdb_id, "movie","maindetails", result)
      puts result.inspect
      Movie.new(result["data"])
    end

    def find_by_title(title)
      movie_results = []
      results = self.class.get('/find', :query => {:q => title}).parsed_response  
      if results["data"]["results"]
        results["data"]["results"].each do |result_section|
          result_section["list"].each do |r| 
            h = {:title => r["title"], :year => r["year"], :imdb_id => r["tconst"]}
            h.merge!(:poster_url => r["image"]["url"]) if r["image"] && r["image"]["url"]
            movie_results << h if r["type"] == "feature"
          end
        end
      end   
      movie_results
    end

    def get_plot(imdb_id)
   result = self.class.get('/title/plot', :query => {:tconst => imdb_id}).parsed_response
    result
    end

    def fullCredits(imdb_id)
     result = self.class.get('/title/fullcredits', :query => {:tconst => imdb_id}).parsed_response
     result
    end

  def coming_soon
     results = self.class.get('/feature/comingsoon').parsed_response
     results['data']['list']
  end

    def this_weekend
      results = self.class.get('/feature/comingsoon').parsed_response
      results = results['data']['list']['list'][0]['list']
      return results

    end

def custom_movie_search(imdb_id, query)
       result = self.class.get("/title/#{query}", :query => {:tconst => imdb_id}).parsed_response
      puts result.inspect
      data = result
      data
   end

  def custom_search(query)
    results = self.class.get("/#{query}").parsed_response
    results
  end

#not working yet
  def company_test(id, query)
    result = self.class.get("/company/#{query}", :query => {:cconst => id}).parsed_response 
     data = result
     data
  end

#invalid JSON string
  def getdvd
    result = self.class.get("/products/bestsellers", :query => {:marketplace => 'US', :media => 'dvd'})
   end
   
   def json_data(id)
    self.class.get('/title/maindetails', :query => {:tconst => id}).parsed_response
   end

    def top_250
      results = self.class.get('/chart/top').parsed_response
      results["data"]["list"]["list"].map { |r| {:title => r["title"], :imdb_id => r["tconst"], :year => r["year"], :poster_url => (r["image"] ? r["image"]["url"] : nil)} }
    end
 
   def getBestPicture
       self.class.get('/feature/best_picture').parsed_response
   end

   def person(person_id)
        result = self.class.get('/name/maindetails', :query => {:nconst => person_id}).parsed_response
        write_file(person_id, "person", 'maindetails', result)
   end
   
  def person2(person_id)
    result = self.class.get('/name/maindetails', :query => {:nconst => person_id}).parsed_response
    person = Person.new(result["data"])
  end

  def popularmoviegenre(genre)
   result = self.class.get('/moviegenre', :query => {:genre => genre}).parsed_response
  end

 def boxoffice
      results = self.class.get('/boxoffice').parsed_response
 end
 
    def popular_shows
      results = self.class.get('/chart/tv').parsed_response
      results["data"]["list"].map { |r| {:title => r["title"], :imdb_id => r["tconst"], :year => r["year"], :poster_url => (r["image"] ? r["image"]["url"] : nil)} }
    end

 def photos(imdb_id)
   result = self.class.get("/title/photos", :query => {:tconst => imdb_id}).parsed_response
   result = result['data']['photos']
   end

 def starmeter
   self.class.get('/chart/starmeter').parsed_response
 end

  def moviemeter
    self.class.get('/chart/moviemeter').parsed_response
  end

  def news
   self.class.get('/news').parsed_response
  end
  
  def getBornToday
   self.class.get('feature/borntoday', :query => {:date => Date.today}).parsed_response
  end

  end
end



