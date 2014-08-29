class DataProcessor
  module Manipulate

    def manipulate(path, override=false)
      obj, parent_obj = traverse_path(@data, path)

      # execute block with object and parent object as params
      # ie. if the object is found
      # + override object with return value of block if needed
      if block_given? && obj
        block_return_value = yield(obj, parent_obj)
        parent_obj[path.split("/").last] = block_return_value if override
      end
    end

  end
end
