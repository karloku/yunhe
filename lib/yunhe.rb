module Yunhe
  require 'yunhe/version'

  autoload :Core,       'yunhe/core'

  ##
  # Default options for new yunhe

  DEFAULT_OPTIONS = {
    producer_size: 1,
    consumer_size: 5,
    queue_size: 100,
  }

  def self.build(options={})
    options = DEFAULT_OPTIONS.merge(options)
    return Core.new(options)
  end

end