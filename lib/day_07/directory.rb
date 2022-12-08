class Directory
  attr_reader :name, :directories, :files, :parent

  def initialize(name:)
    @name = name
    @files = []
    @directories = []
    @parent = nil
  end

  def set_parent(directory)
    @parent = directory
  end

  def add_file(file)
    @files << file
  end

  def add_directory(directory)
    directory.set_parent(self)
    @directories << directory
  end

  def change_directory(name)
    case name
    when ".."
      return move_out
    when "/"
      return get_root_directory
    else
      return move_in(name)
    end
  end

  def file_size
    return 0 if files.empty?

    total_size = files.sum { |file| file.size }
  end

  def size(&proc)
    total = 0

    directories.each do |dir|
      parent_dir_size = dir.size(&proc)
      total += parent_dir_size
    end

    total_size = total + file_size
    proc.call(self.name, total_size) if block_given?

    total_size
  end

  def get_root_directory
    return self if parent == nil

    until (parent == nil)
      change_directory(parent)
    end
  end

  def move_out
    return parent.nil? ? self : parent
  end

  def move_in(dir_name)
    directories.each do |dir|
      return dir if dir.name == dir_name
    end

    return self #directory not found
  end

  def to_h
    {
      name: name,
      parent: parent&.name,
      files: files.map(&:to_h),
      size: size { |dir_name, size| dir_name == name; size },
      directories: directories.map(&:to_h)
    }
  end
end
