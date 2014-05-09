require_relative 'modulus/engine'
require_relative 'window_state'

class EngineState < WindowState
  def initialize window
    super
    
    @engine = Modulus::Engine.new window
  end

  def button_up id
    @engine.button_up id
  end

  def button_down id
    @engine.button_down id
  end

  def update
    @engine.update
  end

  def draw
    @engine.draw
  end
end