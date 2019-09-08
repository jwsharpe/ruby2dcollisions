class Gamepad
  attr_reader :digital_output_x, :digital_output_y
  attr_accessor :magnitude, :deadzone

  def initialize(magnitude: 50, deadzone: 0.10)
    @digital_output_x = 0
    @digital_output_y = 0
    @magnitude = magnitude
    @deadzone = deadzone
  end

  def update_digital_output(event)
    case event.axis
    when :left_x
      @digital_output_x = controller_value_to_integer_casting(event.value)
    when :left_y
      @digital_output_y = controller_value_to_integer_casting(event.value)
    end
  end

  private def controller_value_to_integer_casting(analog)
    analog.abs > @deadzone ? (analog * @magnitude).round : 0
  end
end
