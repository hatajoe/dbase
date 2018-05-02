#
# Sessionable manipulates the session store
#
module Sessionable
  #
  # @param [Symbol] key
  # @param [Object] value
  #
  def store(key, value)
    session[key] = value
  end

  #
  # @param [Symbol] key
  # @return [Object]
  #
  def retrieve(key)
    session[key]
  end

  #
  # @param [Symbol] key
  #
  def delete(key)
    session[key] = nil
  end
end
