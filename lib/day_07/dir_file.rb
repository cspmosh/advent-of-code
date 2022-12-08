class DirFile
  attr_reader :name, :size

  def initialize(name:, size:)
    @name = name
    @size = size
  end

  def to_s
    "- #{name} (file, size=#{size.to_s})"
  end

  def to_h
    {
      name: name,
      size: size
    }
  end
end
