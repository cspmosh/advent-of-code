require 'day_18/lava_droplet'
require 'set'

describe LavaDroplet do
  let(:droplet) { described_class.new }

  describe "#surface_area" do
    context "when 2 molecules do not touch" do 
      it "counts 12 exposed sides" do
        droplet.add_molecule(x: 1, y: 1, z: 1)
        droplet.add_molecule(x: 5, y: 5, z: 5)

        expect(droplet.surface_area).to eq(12)
      end
    end

    context "when 2 molecules touch" do
      it "counts 10 exposed sides" do
        droplet.add_molecule(x: 1, y: 1, z: 1)
        droplet.add_molecule(x: 2, y: 1, z: 1)

        expect(droplet.surface_area).to eq(10)
      end
    end

    context "when molecules surround a pocket of air" do
      it "counts only the external sides" do
        droplet.add_molecule(x: 1, y: 2, z: 2)
        droplet.add_molecule(x: 3, y: 2, z: 2)
        droplet.add_molecule(x: 2, y: 3, z: 2)
        droplet.add_molecule(x: 2, y: 1, z: 2)
        droplet.add_molecule(x: 2, y: 2, z: 3)
        droplet.add_molecule(x: 2, y: 2, z: 1)
        # 2, 2, 2 is empty

        expect(droplet.surface_area).to eq(30)
      end

      
    end
  end

  describe "#air_pockets" do
    context "when molecules surround an empty space" do
      it "returns the coordinates of the air pocket" do

      end
    end
  end
end