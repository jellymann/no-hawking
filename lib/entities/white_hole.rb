require_relative '../modulus/entity'

class WhiteHole < Entity
  include Drawable
  include Emitter
  include Position

  def initialize x, y, sprite, particle_sprite, engine
    super(engine)

    init_position x, y
    init_drawable sprite
    init_emitter 0.5, 20, 3, particle_sprite
    init_pulse 0.2, Gosu::random(0.7,0.9), Gosu::random(1.1,1.3), Gosu::random(0.6,1.4), 20

    @activate_radius = sprite.width/2.0
    @universe = {}

    @colour = Gosu::Color.rgba(Gosu::random(127,255).to_i, Gosu::random(127,255).to_i,
        Gosu::random(127,255).to_i, 255)
  end

  def activate_radius
    @activate_radius
  end

  def universe
    @universe
  end

  def universe= uni
    @universe = uni
  end

  def update
    do_emitter dt, t
    do_pulse dt, t
  end

  def init_pulse period, min, max, size, velocity
    @pulse_period = period
    @pulse_min = min
    @pulse_max = max
    @pulse_size = size
    @pulse_velocity = velocity
  end

  def do_pulse dt, t
    if t-@last_pulse > @pulse_period
      pulse_factor = Gosu::random(@pulse_min,@pulse_max)
      scale = @pulse_size*pulse_factor
      @particle_speed = @pulse_velocity*scale
      @sx = @sy = scale
    end
  end
end