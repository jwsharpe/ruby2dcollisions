#Overriding the Ruby2D rectangle class to add collision detection
class Rectangle
  def collided_with?(rect)
    self_bounding_points =
      [
        Point.new(self.x, self.y),
        Point.new(self.x, self.y + self.height),
        Point.new(self.x + self.width, self.y),
        Point.new(self.x + self.width, self.y + self.height),
      ]

    rect_bounding_points =
      [
        Point.new(rect.x, rect.y),
        Point.new(rect.x + rect.width, rect.y + rect.height),
      ]

    self_bounding_points.any? { |point|
      point.x >= rect_bounding_points[0].x &&
      point.y >= rect_bounding_points[0].y &&
      point.x <= rect_bounding_points[1].x &&
      point.y <= rect_bounding_points[1].y
    }
  end
end

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end
