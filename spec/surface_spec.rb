require 'spec_helper'

describe Surface do
  let(:klass) { described_class }
  let(:vector) { Vector[Random.rand(50)+1, Random.rand(50)+1] }
  let(:color) { Color[Random.rand(254)+1, Random.rand(254)+1, 0, 255] }
  let(:instance) { klass.new(vector, color) }

  describe '::new' do
    subject(:method) { klass.method :new }

    it { expect { method.call }.to raise_error ArgumentError }

    it "accepts a Vector size" do
      surface = method.call(vector)
      surface.size.should eq vector
    end

    it "accepts a Color color" do
      surface = method.call(vector, color)
      surface.color_at(vector/2).should eq color
    end
  end

  describe '#size' do
    subject { instance.size }

    it { should eq vector }
  end

  describe '#size=' do
    subject(:method) { instance.method(:size=) }

    it_behaves_like 'writer', Vector[20, 20]
  end

  describe '#data' do
    subject(:data) { instance.data }

    it "has length of #size.x * #size.y * 4" do
      instance.size = instance.size * 2
      expected_length = instance.size.x * instance.size.y * 4
      data.length.should eq expected_length
    end

    it "is repeatedly \x00\x00\x00\xFF by default" do
      pixels = data.unpack('H*')[0].scan(/.{8}/)
      pixels.uniq.size.should eq 1
      pixels.first.should eq "000000ff"
    end
  end

  describe '#color_at' do
    subject(:method) { instance.method(:color_at) }

    it { expect { method.call }.to raise_error ArgumentError }

    it "matches the color of the pixel at position" do
      method.call(Vector[]).should eq color
    end
  end

  describe '#draw_rectangle' do
    subject(:method) { instance.method(:draw_rectangle) }
    let(:rectangle) { Rectangle.new(vector/2, Color[0, 255, 0, 255]) }

    it { expect { method.call }.to raise_error ArgumentError }
    it { expect { method.call(vector) }.to raise_error ArgumentError }

    it "changes color of rectangular area" do
      method.call(Vector[], rectangle)
      instance.color_at(Vector[]).should eq Color[0, 255, 0, 255]
      instance.color_at(vector/2+1).should eq color
    end
  end
end
