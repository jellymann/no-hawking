require_relative '../../engine/component'

class Letter < Garbage::Component
  def initialize letter
    @letter = letter
  end

  def value
    @letter
  end

  def on_hit other, point
    # TODO: make explosion
    @entity.destroy!
  end

end
