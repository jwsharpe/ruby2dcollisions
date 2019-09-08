class Player < Square
  def move(x:, y:)
    self.x += x
    self.y += y
  end
end
