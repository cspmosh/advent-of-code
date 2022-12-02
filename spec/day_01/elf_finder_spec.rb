require "day_01/elf_finder"

describe ElfFinder do
  describe "#top_caloric_elfs" do
    let(:elf_1) { Elf.new(snacks: [1,2,3]) }
    let(:elf_2) { Elf.new(snacks: [4,5,6]) }
    let(:elf_3) { Elf.new(snacks: [8])}

    it "returns the top elf with the most calories" do
      finder = ElfFinder.new(elfs: [elf_1, elf_2, elf_3])

      top_elfs = finder.top_caloric_elfs(2)

      expect(top_elfs.sum { |elf| elf.total_calories }).to eq(23)
    end
  end
end
