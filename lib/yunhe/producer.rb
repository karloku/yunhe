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
        result = block.call
        if result.respond_to? :each
          result.each do |res|
            queue.enq res
          end
        else
          queue.enq result
        end
      end
    end
  end
end