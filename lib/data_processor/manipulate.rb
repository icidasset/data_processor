class DataProcessor
  module Manipulate

    def manipulate(path)
      obj = @data

      if block_given?
        counter = 0
        path_split = path.split("/")

        path_split.each do |p|
          if obj && obj[p]
            obj = obj[p]
            counter = counter + 1
          else
            obj = nil
          end
        end

        if obj && (counter == path_split.length)
          yield(obj)
        end
      end

      obj
    end

  end
end
