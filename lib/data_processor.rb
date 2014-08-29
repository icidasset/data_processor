require "yaml"
require "redcarpet"
require "oj"

require "data_processor/getters"
require "data_processor/helpers"
require "data_processor/import"
require "data_processor/manipulate"
require "data_processor/output"

class DataProcessor
  include DataProcessor::Getters
  include DataProcessor::Helpers
  include DataProcessor::Import
  include DataProcessor::Manipulate
  include DataProcessor::Output

  def initialize(initial_path="./")
    @initial_path = initial_path.sub(/\/+$/, "")
    @data = {}

    create_markdown_parser
  end


  #
  #  Markdown
  #
  def self.markdown_renderer
    Redcarpet::Render::HTML
  end


  def create_markdown_parser
    @markdown_parser = Redcarpet::Markdown.new(
      DataProcessor::markdown_renderer,
      fenced_code_blocks: true,
      strikethrough: true,
      superscript: true,
      underline: true,
      highlight: true,
      smartypants: true
    )
  end


  def parse_markdown(string)
    @markdown_parser.render(string)
  end

end
