class WindowGenerator
  STRATEGIES = [:clone]

  def initialize(arr, window_size)
    @arr = arr
    @window_size = window_size
  end

  def via(strategy)
    unless STRATEGIES.include? strategy
      fail ArgumentError, "Unsupported option #{strategy.inspect.to_s}"
    end
  end

  private
  def windows(strategy)
    return to_enum(__callee__, arr, window_size) unless block_given?
    prefix = arr.slice(0, window_size-1)
    arr[(window_size-1)..-1].each do |elt|
      prefix << elt
      yield prefix #.clone
      prefix.delete_at 0
    end
  end

  attr_accessor :digits, :window_size
end
