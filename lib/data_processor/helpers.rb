class DataProcessor
  module Helpers

    def traverse_path(object, path, use_symbols=false)
      obj = object
      parent_obj = nil
      path_split = path.split("/")
      counter = 0

      # down the rabbit hole
      path_split.each do |p|
        p = p.to_sym if use_symbols

        if obj && obj[p]
          parent_obj = obj
          obj = obj[p]
          counter = counter + 1
        else
          parent_obj = nil
          obj = nil
        end
      end

      if obj && (counter == path_split.length)
        return obj, parent_obj
      end
    end

  end
end
