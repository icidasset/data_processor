class DataProcessor
  module Manipulate

    def manipulate(path, override=false)
      obj = @data
      parent_obj = nil

      if block_given?
        counter = 0
        path_split = path.split("/")

        # down the rabbit hole
        path_split.each do |p|
          if obj && obj[p]
            parent_obj = obj
            obj = obj[p]
            counter = counter + 1
          else
            parent_obj = nil
            obj = nil
          end
        end

        # execute block with object as param
        # ie. if the object is found
        # + override object with return value of block if needed
        if obj && (counter == path_split.length)
          return_value = yield(obj, parent_obj)
          parent_obj[path_split.last] = return_value if override
        end
      end

      obj
    end

  end
end
