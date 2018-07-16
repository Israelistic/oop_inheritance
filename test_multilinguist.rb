require 'minitest/autorun'
require 'minitest/pride'
require './multilinguist.rb'

class TestMultilinguist < MiniTest::Test
    def setup
        @traveller = Multilinguist.new
    end

      def test_language_in
          traveller = Multilinguist.new
          assert_equal(@traveller.language_in('Canada'), 'en')
          assert_equal(@traveller.language_in('France'), 'fr')
          assert_equal(@traveller.language_in('Japan'), 'ja')
      end


      def test_say_in_local_language
        msg = @traveller.say_in_local_language('good night')
        assert_equal(msg, 'good night')
      end
      def test_travel_to
         @traveller.travel_to('japan')
         assert_equal('ja', @traveller.current_lang)

       end

end
