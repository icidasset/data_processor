require "yaml"
require "redcarpet"
require "oj"

require "data_processor/getters"
require "data_processor/import"
require "data_processor/manipulate"
require "data_processor/output"

class DataProcessor
  include DataProcessor::Getters
  include DataProcessor::Import
  include DataProcessor::Manipulate
  include DataProcessor::Output

  def initialize(initial_path="./")
    @data = {}
    @initial_path = initial_path

    create_markdown_parser
  end


  #
  #  Markdown
  #
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


  def self.markdown_renderer
    Redcarpet::Render::HTML
  end

end
