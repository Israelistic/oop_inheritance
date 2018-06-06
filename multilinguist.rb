require 'httparty'
require 'json'


# This class represents a world traveller who knows what languages are spoken in each country
# around the world and can cobble together a sentence in most of them (but not very well)
class Multilinguist

  TRANSLTR_BASE_URL = "http://bitmakertranslate.herokuapp.com"
  COUNTRIES_BASE_URL = "https://restcountries.eu/rest/v2/name"
  #{name}?fullText=true
  #?text=The%20total%20is%2020485&to=ja&from=en


  # Initializes the multilinguist's @current_lang to 'en'
  #
  # @return [Multilinguist] A new instance of Multilinguist
  def initialize
    @current_lang = 'en'
  end

  # Uses the RestCountries API to look up one of the languages
  # spoken in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] A 2 letter iso639_1 language code
  def language_in(country_name)
    params = {query: {fullText: 'true'}}
    response = HTTParty.get("#{COUNTRIES_BASE_URL}/#{country_name}", params)
    json_response = JSON.parse(response.body)
    json_response.first['languages'].first['iso639_1']
  end

  # Sets @current_lang to one of the languages spoken
  # in a given country
  #
  # @param country_name [String] The full name of a country
  # @return [String] The new value of @current_lang as a 2 letter iso639_1 code
  def travel_to(country_name)
    local_lang = language_in(country_name)
    @current_lang = local_lang
  end

  # (Roughly) translates msg into @current_lang using the Transltr API
  #
  # @param msg [String] A message to be translated
  # @return [String] A rough translation of msg
  def say_in_local_language(msg)
    params = {query: {text: msg, to: @current_lang, from: 'en'}}
    response = HTTParty.get(TRANSLTR_BASE_URL, params)
    json_response = JSON.parse(response.body)
    json_response['translationText']
  end
end

 list_num =[22, 33, 44, 66, 77, 55, 332]

class Mathgenius < Multilinguist
    def initialize
      @numbers
    end

  def report_total(list_num)
      numbers = list_num
      numbers.sum
      in_lang = say_in_local_language("The total is")

      return  "#{in_lang} #{numbers.sum}"

  end



end

class Quotacollector < Multilinguist

    def initialize
      @quotes =[]
    end
    def quotes
      return @quotes
    end
    def memorize(new_quotes)
        @quotes << new_quotes
    end
    def randum_quotes
      array_length = @quotes.length
      randumaly_quotes  =  @quoes.rand(array_length)
       p say_in_local_language(randumaly_quotes)
    end

end

p "====main menu===="

p "creating new Mathgenius"
p mathgen = Mathgenius.new
p mathgen.report_total(list_num)
p mathgen.travel_to("germany")
p mathgen.report_total(list_num)
p mathgen.travel_to("Canada")
p mathgen.memorize("Don't cry because it's over, smile because it happened.")
p mathgen.memorize("Be yourself; everyone else is already taken.")
p mathgen.memorize("Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.")
p mathgen.randum_quotes
p mathgen.travel_to("netherland")
p mathgen.report_total(list_num)
p mathgen.randum_quotes
