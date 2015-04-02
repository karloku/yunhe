# Yunhe:运河 - Canal
Yunhe is a light weight gem that implements the Producer/Consumer pattern using threads.
## Installation
    gem install yunhe
## Usage
    require 'yunhe'
    # options
    options = {
      producer_size: 1,   # size of producer thread pool
      consumer_size: 5,   # size of consumer thread pool
      queue_size: 100     # size of buffer queue
    }
    yunhe = Yunhe.build(options)
    yunhe.produce_by do 
      Date.now
    end
    yunhe.consume_with do |res|
      puts res
    end

    # stop the canal
    yunhe.terminate
