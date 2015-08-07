require_relative "../window_generator.rb"

RSpec.describe WindowGenerator do
  let(:digits) { (1..10).to_a.shuffle }
  let(:window_size) { 4 }

  subject(:generator) { WindowGenerator.new digits, window_size }

  describe "#via" do
    it "fails for unknown strategies" do
      expect { generator.via(:foobar) }.to raise_error(ArgumentError)
    end
  end
end
