$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "minitest/autorun"
require "data_processor"

class TestDataProcessor < MiniTest::Unit::TestCase

  def setup
    @d = ::DataProcessor.new("./test/fixtures/")
  end


  def test_initial_data_object
    assert_kind_of Hash, @d.get_data
  end


  def test_import
    @d.import("data/")
    data = @d.get_data

    assert_kind_of Hash, data["en"]
    assert_kind_of Hash, data["en"]["base"]
    assert_kind_of Hash, data["en"]["pages"]
    assert_kind_of Hash, data["en"]["pages"]["index"]

    assert_equal(
      "<p>Parsed markdown from index.md</p>\n",
      data["en"]["pages"]["index"]["parsed_markdown"]
    )

    assert_equal(
      "1",
      data["en"]["pages"]["index"]["value_from_index_yaml"]
    )
  end


  def test_manipulate
    @d.import("data/")

    # manipulate
    @d.manipulate("en") { |obj| obj["locale"] = "en" }

    # get data
    data = @d.get_data

    # assertions
    assert_equal(
      "en",
      data["en"]["locale"]
    )
  end


  def test_output
    @d.import("data/")

    # data
    data = @d.get_data
    parsed_json = Oj.load(@d.output_json)

    # assertions
    assert_equal(
      parsed_json["en"]["pages"]["index"]["value_from_index_yaml"],
      data["en"]["pages"]["index"]["value_from_index_yaml"]
    )
  end

end
