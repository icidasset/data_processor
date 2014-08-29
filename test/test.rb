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
    @d.manipulate("en/pages", true) { |obj| obj.to_a }

    # get data
    data = @d.get_data

    # assertions
    assert_equal(
      "en",
      data["en"]["locale"]
    )

    assert_kind_of(
      Array,
      data["en"]["pages"]
    )
  end


  def test_output
    @d.import("data/")

    # data
    data = @d.get_data
    parsed_json = Oj.load(@d.output_json)
    sub_parsed_json = Oj.load(@d.output_json("en"))

    # assertions
    assert_equal(
      parsed_json["en"]["pages"]["index"]["value_from_index_yaml"],
      data["en"]["pages"]["index"]["value_from_index_yaml"]
    )

    assert_equal(
      sub_parsed_json["pages"]["index"]["value_from_index_yaml"],
      data["en"]["pages"]["index"]["value_from_index_yaml"]
    )
  end


  def test_helpers
    data = { "a" => { "b" => { "c" => "D" }}}
    data_symbols = { a: { b: { c: "D" }}}

    # test 1
    obj, parent_obj = @d.traverse_path(data, "a/b")

    assert_kind_of(Hash, obj)
    assert_kind_of(String, obj["c"])

    # test 2
    obj, parent_obj = @d.traverse_path(data_symbols, "a/b", true)

    assert_kind_of(Hash, obj)
    assert_kind_of(String, obj[:c])

    # test 3
    obj, parent_obj = @d.traverse_path(data, "unknown")

    assert_kind_of(NilClass, obj)
  end

end
