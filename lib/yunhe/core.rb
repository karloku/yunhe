module Yunhe
  autoload :Producer,   'yunhe/producer'
  autoload :Consumer,   'yunhe/consumer'

  ##
  # The core class that manages the producers and consumers.

  class Core
    attr_reader :producer_pool, :consumer_pool
    attr_reader :queue
    attr_accessor :producer_size, :consumer_size, :queue_size

    ##
    # Initialize a new yunhe core with options:
    # :producer_size      => Size of the producer pool
    # :consumer_size      => Size of the consumer pool
    # :queue_size         => Size of the buffer queue
    def initialize(options)
      @producer_size = options[:producer_size]
      @consumer_size = options[:consumer_size]
      @queue_size = options[:queue_size]

      @producer_pool = ThreadGroup.new
      @consumer_pool = ThreadGroup.new
      @queue = SizedQueue.new(queue_size)
    end

    # readers

    ##
    # Get the producer pool
    def producer_pool
      @producer_pool = ThreadGroup.new unless @producer_pool
      @producer_pool
    end

    ##
    # Get the consumer pool
    def consumer_pool
      @consumer_pool = ThreadGroup.new unless @consumer_pool
      @consumer_pool
    end

    ##
    # Get the buffer queue

    def queue
      @queue = SizedQueue.new(@queue_size) unless @queue
      @queue
    end

    # producer/consumer task setters

    ##
    # Set the producer task
    # &task: The task that produces a new resource. Should have the resource returned:
    #   do 
    #     ...
    #     return resource
    #   end
    def produce_by (&task)
      each_producer do | thread |
        thread.kill
      end

      producer_size.times do 
        thread = Producer.new(queue, task)
        producer_pool.add(thread)
      end
    end

    ##
    # Set the consumer task
    # &task: The task that process the resources. Should take the resource as a paramater:
    #   do | resource |
    #     ...
    #   end
    def consume_with (&task)
      each_consumer do | thread |
        thread.kill
      end

      consumer_size.times do
        thread = Consumer.new(queue, task)
        consumer_pool.add(thread)
      end
    end

    ## Stop the yunhe core. Kill all producer/consumer threads, and clear the buffer queue.
    def terminate
      each_producer do | thread |
        thread.kill
      end

      each_consumer do | thread |
        thread.kill
      end

      queue.clear
    end

    private
    def each_producer(&block)
      producer_pool.list.each &block if producer_pool
    end

    def each_consumer(&block)
      consumer_pool.list.each &block if consumer_pool
    end
  end
end