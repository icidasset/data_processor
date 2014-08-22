class DataProcessor
  module Import

    def import(path="", data_obj=nil)
      path = path.sub(/^\//, "")

      data_hash = data_obj || @data
      full_path = @initial_path + path

      Dir.foreach(full_path) do |filename|
        next if filename[0] == "."
        combined_path = File.join(full_path, filename)

        # directory
        if File.directory?(combined_path)
          data_hash[filename] ||= {}
          data_hash[filename].merge!(import(File.join(path, filename), data_hash[filename]))
          data_hash[filename].merge!({ "is_directory" => true })

        # yaml file
        elsif filename.end_with?(".yml")
          without_ext = File.basename(filename, ".yml")
          yaml_data = YAML.load_file(combined_path) || {}

          data_hash[without_ext] ||= {}
          data_hash[without_ext].merge!(yaml_data)
          data_hash[without_ext].merge!({ "is_yaml" => true })

        # markdown file
        elsif filename.end_with?(".md")
          without_ext = File.basename(filename, ".md")
          file = File.open(combined_path, "r")
          parsed_markdown = @markdown_parser.render(file.read)
          file.close

          data_hash[without_ext] ||= {}
          data_hash[without_ext].merge!({ "parsed_markdown" => parsed_markdown })
          data_hash[without_ext].merge!({ "is_markdown" => true })

        end
      end

      data_hash
    end

  end
end
