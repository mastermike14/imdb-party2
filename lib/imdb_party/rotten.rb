module ImdbParty
  
  class Rotten
    include HTTParty
    #include HTTParty::Icebox
    #cache :store => 'file', :timeout => 120, :location => Dir.tmpdir
    base_uri 'api.rottentomatoes.com/api/public/v1.0'
    default_params :apikey => 'ymxs2mkgt3q4crr3zgpaxb8e'

   BASE_LIST_URL = "/lists/movies"

  def writeFile(imdb_id, dir, json)
  open("#{RAILS_ROOT}/json/imdb/#{dir}/#{imdb_id}.json", "w+")  { |file| file.write(json) }
  end

  #Movie 
  def movie_info(id)
    results = self.class.get("/movies/#{id}.json").parsed_response
    return results
  end
  
  def cast(id)
    results = self.class.get("/movies/#{id}/cast.json").parsed_response
    return results
  end
  #ID required
  #Options
  #Review type - 3 different review types are possible: 'all', 'top_critic' and 'dvd'. 'top_critic' shows all the Rotten Tomatoes designated top critics. '
  #dvd' pulls the reviews given on the DVD of the movie. '
  #all' as the name implies retrieves all reviews.
  def reviews(id, review_type='top_critic', page_limit='20', page='1', country='us')
    results = self.class.get("/movies/#{id}/reviews.json", :query => {:review_type => review_type, :page_limit => page_limit, :page => page, :country => country}).parsed_response
    return results
  end
  
  def similar(id, limit='5')
    results = self.class.get("/movies/#{id}/similar.json", :query => { :limit => limit}).parsed_response
    return results
  end
  
  #Look up movie by id from different vendor
  #currently only IMDB is supported
  def alias(id, type='imdb')
    results = self.class.get('/movie_alias.json', :query => { :type => type, :id => id }).parsed_response
    return results
  end
  
 #Movie Lists
 
 def BoxOffice(country='us', limit='10')
   results = self.class.get("#{BASE_LIST_URL}/box_office.json", :query => {:country => country, :limit => limit}).parsed_response
   return results
 end

 def InTheatres(country='us', page_limit='20', page='1')
   results = self.class.get("#{BASE_LIST_URL}/opening.json", :query => {:country => country, :page_limit => page_limit, :page => page}).parsed_response
   return results
 end
 
 def opening(country = 'us', limit='10')
   results = self.class.get("#{BASE_LIST_URL}/opening.json", :query => {:country => country, :limit => limit}).parsed_response
   return results
 end

 def upcoming(country='us', page_limit='50', page='1')
  results = self.class.get("#{BASE_LIST_URL}/opening.json", :query => {:country => country, :page_limit => page_limit, :page => page}).parsed_response
  return results
end
 
 #DVD LISTS
 
  def new_dvd_release(page='1', country='us', page_limit='20')
    results = self.class.get('/lists/dvds/new_releases.json', :query => {:page => page, :page_limit => page_limit, :country => country }).parsed_response
    return results  
 end
 
  end
end



