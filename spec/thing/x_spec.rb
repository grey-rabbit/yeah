require_relative 'shared/coordinate'

describe Thing do
  let(:instance) { described_class.new }
  before { instance.position = random_vector }

  describe '#x' do
    subject { instance.x }

    it { should eq instance.position[0] }
  end

  describe '#x=' do
    subject { instance.method(:x=) }

    it_behaves_like 'writer', Random.rand(10)
  end
end