require 'day_10/crt'

describe CRT do
  let(:crt) { described_class.new }

  describe "#move_sprite" do
    it "moves the sprite to the given position" do
      expect(crt.sprite_position).to eq((-1..1))
      crt.move_sprite(5)
      expect(crt.sprite_position).to eq((4..6))
    end
  end

  describe "#draw_pixel" do
    before do
      allow(crt).to receive(:print)
    end

    context "when the sprite overlays the position of the pixel" do
      before do
        crt.move_sprite(10)
      end

      it "draws a the correct character" do
        crt.draw_pixel(9)
        crt.draw_pixel(10)
        crt.draw_pixel(11)
        expect(crt).to have_received(:print).with("#").exactly(3).times
      end
    end

    context "when the sprite does NOT overlay the position of the pixel" do
      before do
        crt.move_sprite(1)
      end

      it "draws a the correct character" do
        crt.draw_pixel(4)
        expect(crt).to have_received(:print).with(".").once
      end
    end
  end
end
