# Data Processor

Parse YAML and Markdown files, manipulate their data and convert it to JSON.



## Dependencies

- Redcarpet
- Oj



## How it works

_File structure:_

```
/example_path/en/base.yaml
/example_path/en/pages/index.yaml
/example_path/en/pages/index.md
```

_JSON Output: (by using the code below)_

```json
{
  "en": {
    "is_directory": true,
    "locale": "en",
    
    "base": {
      "value_from_base_yaml": "1"
    },
    
    "pages": {
      "is_directory": true,
      
      "index": {
        "title": "Homepage Title",
        "slug": "homepage-title",
        
        "parsed_markdown": "<p>Parsed markdown from index.md</p>",
        
        "is_yaml": true,
        "is_markdown": true
      }
    }
  }
}
```

_Ruby Hash:_

Pretty much the same as the JSON output, strings as keys, not symbols.



## Usage

```ruby
# New instance
# -> takes path as first argument, default is current directory
d = DataProcessor.new("/")

# Import data
# -> takes path as first argument, default is initial directory
d.import("example_path/")

# Manipulate data
# -> 1st arg, the path without file extension (string)
# -> 2nd arg, override, obj will be set to the return value of the block (boolean, optional)
# -> block to execute manipulations in
d.manipulate("en") { |obj| obj["locale"] = "en" }
d.manipulate("en/pages/index") { |obj| obj["slug"] = obj["title"].to_slug }

# Output
d.get_data # ruby hash
d.output_json # json
```



## Install

```ruby
# Gemfile

gem 'data_processor'
```



## Markdown

Redcarpet is used here to parse markdown. You can override the markdown renderer by overriding `DataProcessor::markdown_renderer`, which returns a renderer.
