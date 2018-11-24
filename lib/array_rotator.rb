class ArrayRotator

  attr_accessor :array
  def initialize(array)
    @array = array.clone
  end

  def rotate(k_times)
    k = k_times.to_i
    return @array if @array.empty?
    if k.positive?
      first = k % @array.length
      @array = @array.slice!(-first, @array.length).concat(@array)
    else
      raise ArgumentError, 'Zero or negative argument given, positive k expected.'
    end
  end

end
