class DataProcessor
  module Output

    def output_json(path=nil)
      if path
        obj, parent_obj = traverse_path(@data, path)
        Oj.dump(obj || {})

      else
        Oj.dump(@data)

      end
    end

  end
end
