module Yeah
module Platform

# An `Asset` represents a file in a game project's `assets` directory.
# @abstract Subclassed to more specific assets.
class Asset
  def initialize(path)
    raise NotImplementedError
  end

  # @!attribute path
  # @param [String] path to asset relative to `assets`
  # @return [String] path to asset relative to `assets`

  # @!method to_n
  # @return [Native] native representation of asset for platform
end
end
end
