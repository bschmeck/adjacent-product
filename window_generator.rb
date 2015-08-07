class WindowGenerator
  STRATEGIES = [:clone, :new_array, :concat, :slice]

  def initialize(arr, window_size)
    @arr = arr
    @window_size = window_size
  end

  def via(strategy, &block)
    unless STRATEGIES.include? strategy
      fail ArgumentError, "Unsupported option #{strategy.inspect.to_s}"
    end
    send("via_#{strategy}", &block)
  end

  private
  def via_clone
    return to_enum(__callee__) unless block_given?
    prefix = arr.slice(0, window_size-1)
    arr[(window_size-1)..-1].each do |elt|
      prefix << elt
      yield prefix.clone
      prefix.delete_at 0
    end
  end

  def via_new_array
    return to_enum(__callee__) unless block_given?
    prefix = arr.slice(0, window_size-1)
    arr[(window_size-1)..-1].each do |elt|
      prefix << elt
      yield Array.new(prefix)
      prefix.delete_at 0
    end
  end

  def via_concat
    return to_enum(__callee__) unless block_given?
    prefix = arr.slice(0, window_size-1)
    arr[(window_size-1)..-1].each do |elt|
      yield prefix + [elt]
      prefix << elt
      prefix.delete_at 0
    end
  end

  def via_slice
    return to_enum(__callee__) unless block_given?
    n_windows = arr.size - window_size + 1
    n_windows.times do |i|
      yield arr.slice(i, window_size)
    end
  end

  attr_accessor :arr, :window_size
end
