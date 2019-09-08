require_relative "lib/bin/enviornment"

fps = Text.new(
  get(:fps).to_i,
  size: 16,
  x: 617,
  y: 460,
)

floor = Rectangle.new(
  x: 0,
  y: Window.height / 3 * 2 - 8,
  width: Window.width,
  height: 16,
  color: "gray",
)
wall = Rectangle.new(
  x: Window.width / 3 * 2 - 8,
  y: 0,
  width: 16,
  height: Window.height,
  color: "gray",
)

#initalize user
user = Player.new(
  x: (Window.width - 20) / 2 - 10,
  y: (Window.height - 20) / 2 - 10,
  size: 40,
  color: "blue",
)

user_bounding_box = Player.new(
  x: user.x,
  y: user.y,
  size: user.size,
  opacity: 0,
)

#initalize gamepad
gamepad = Gamepad.new(
  magnitude: 12,
  deadzone: 0.15,
)

#Ruby2D gives us very easy access to updating controller input
on :controller_axis do |event|
  gamepad.update_digital_output(event)
end

#Ruby2D attempts to redraw the frame 60 times per second.
update do
  fps.text = get(:fps).to_i

  if (user_bounding_box.collided_with?(wall))
    user_bounding_box.x = wall.x - user_bounding_box.width - 1
  elsif (user_bounding_box.collided_with?(floor))
    user_bounding_box.y = floor.y - user_bounding_box.height - 1
  elsif (user_bounding_box.x < 0)
    user_bounding_box.x = 2
  elsif (user_bounding_box.y < 0)
    user_bounding_box.y = 0
  else
    user.x = user_bounding_box.x
    user.y = user_bounding_box.y

    user_bounding_box.move(
      x: gamepad.digital_output_x,
      y: gamepad.digital_output_y,
    )
  end
end

init_window_settings
show
