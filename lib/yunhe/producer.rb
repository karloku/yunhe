module Yunhe
  class Producer < Thread
    attr_accessor :queue
    attr_accessor :block

    def initialize(queue, block)
      super &(method(:job).to_proc)
      @block = block
      self.queue = queue
    end

    private
    def job
      while(true) do
        rtn = block.call
        queue.enq rtn
      end
    end

  end
end