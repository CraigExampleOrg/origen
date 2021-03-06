require 'active_support/concern'
module Origen
  module Callbacks
    extend ActiveSupport::Concern

    included do
      include Origen::ModelInitializer
    end

    def register_callback_listener # :nodoc:
      Origen.app.add_callback_listener(self)
    end
  end

  # The regular callbacks module will register listeners that expire upon the next target
  # load, normally this is what is wanted at app level since things should start afresh
  # every time the target is loaded.
  #
  # However within Origen core (and possibly some plugins) it is often the case that registered
  # listeners will be objects that are not re-instantiated upon target load and persist for
  # the entire Origen thread. In this case use the PersistentCallbacks module instead of the regular
  # Callbacks module to make these objects register as permanent listeners.
  module PersistentCallbacks
    extend ActiveSupport::Concern

    included do
      include Origen::ModelInitializer
    end

    def register_callback_listener # :nodoc:
      Origen.app.add_persistant_callback_listener(self)
    end
  end
  CoreCallbacks = PersistentCallbacks
end
