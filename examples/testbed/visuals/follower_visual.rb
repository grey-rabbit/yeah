class FollowerVisual < Box
  COLORS = {
    default: Color[0.8, 0.5, 0.3], # orange
    charged: Color[0.3, 0.5, 0.8] # blue
  }

  self.size = V[24, 48]

  def color
    thing.charged? ? COLORS[:charged] : COLORS[:default]
  end
end