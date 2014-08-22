class DataProcessor
  module Output

    def output_json
      Oj.dump(@data)
    end

  end
end
