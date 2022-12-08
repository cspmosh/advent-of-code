require 'day_07/directory'
require 'day_07/dir_file'

describe Directory do
  let(:root_directory) { described_class.new(name: "/") }
  let(:subdirectory) { Directory.new(name: "Subdirectory A") }

  describe "#add_file" do
    it "adds the file to the directory" do
      file = DirFile.new(name: "File A", size: 100)

      root_directory.add_file(file)

      expect(root_directory.files).to include(file)
    end
  end

  describe "#add_directory" do
    it "adds the directory within the directory" do
      root_directory.add_directory(subdirectory)

      expect(root_directory.directories).to include(subdirectory)
    end
  end

  describe "#change_directory" do
    context "when the argument is the name of a subdirectory" do
      it "returns the subdirectory" do
        root_directory.add_directory(subdirectory)
        directory = root_directory.change_directory("Subdirectory A")

        expect(directory).to be subdirectory
      end
    end

    context "when the argument is .." do
      it "returns the parent directory" do
        root_directory.add_directory(subdirectory)
        directory = subdirectory.change_directory("..")

        expect(directory).to be root_directory
      end
    end
  end

  describe "#size" do
    it "returns the sum total of all nested file sizes" do
      file_a = DirFile.new(name: "File A", size: 100)
      file_b = DirFile.new(name: "File B", size: 40)
      file_c = DirFile.new(name: "File C", size: 83)

      root_directory.add_file(file_a)
      root_directory.add_file(file_b)
      subdirectory.add_file(file_c)

      root_directory.add_directory(subdirectory)

      expect(root_directory.size).to eq(223)
    end
  end

  describe "#to_h" do
    it "prints out each nested directory and file" do
      file_a = DirFile.new(name: "File A", size: 100)
      file_b = DirFile.new(name: "File B", size: 40)
      file_c = DirFile.new(name: "File C", size: 83)

      root_directory.add_file(file_a)
      root_directory.add_file(file_b)
      subdirectory.add_file(file_c)

      root_directory.add_directory(subdirectory)

      expect(root_directory.to_h).to include(
         :name => "/",
         :parent => nil,
         :size => 223,
         :files => [{:name=>"File A", :size=>100}, {:name=>"File B", :size=>40}],
         :directories => [{:directories=>[], :files=>[{:name=>"File C", :size=>83}], :name=>"Subdirectory A", :parent=>"/", :size=>83}]
      )
    end
  end
end
