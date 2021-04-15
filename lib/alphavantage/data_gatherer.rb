class AlphaVantage::DataGatherer
  def self.get_dates(number_of_days)
    x = 0
    output = []
    now = DateTime.now
    while x < number_of_days.to_i
      date = now - x
      output.append(date.strftime('%Y-%m-%d'))
      x += 1
    end
    return(output)
  end

  def self.calculate_closing(data,number_of_days)
    final_result = {}
    data.each do |k,v|
      if self.get_dates(number_of_days).include?(k)
        final_result[k] = v['4. close']
      end
    end
    return(final_result)
  end

  def self.get_average(numbers)
    # need to convert these to float instead of integers
    output = numbers.inject(0) {|k,v| k.to_f + v[1].to_f }
    return(output / numbers.values.size)
  end

  def self.combine_data(data,days)
    closing = self.calculate_closing(data,days)
    average = self.get_average(closing)
    closing['average'] = average
    return(closing.to_json)
  end
end
