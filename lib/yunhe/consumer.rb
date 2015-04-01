module Yunhe
  class Consumer < Thread
    attr_accessor :queue
    attr_accessor :block

    ##
    # Initialize a new consumer
    # queue: the reference of the buffer queue
    # block: the task to process the resource
    def initialize(queue, block)
      super &(method(:job).to_proc)
      @block = block
      self.queue = queue
    end

    private
    def job
      while(true) do
        ele = queue.deq
        block.call(ele)
      end
    end
  end
end