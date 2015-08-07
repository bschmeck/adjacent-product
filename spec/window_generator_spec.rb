require_relative "../window_generator.rb"

RSpec.describe WindowGenerator do
  let(:digits) { (1..10).to_a }
  let(:window_size) { 4 }

  subject(:generator) { WindowGenerator.new digits, window_size }

  describe "#via" do
    it "fails for unknown strategies" do
      expect { generator.via(:foobar) }.to raise_error(ArgumentError)
    end

    WindowGenerator::STRATEGIES.each do |strategy|
      context "when strategy is #{strategy}" do
        it "yields unique objects" do
          expect(generator.via(strategy).to_a.uniq.count).to eq 7
        end

        it "yields the correct windows" do
          enum = generator.via(strategy)
          expect(enum.next).to eq [1,2,3,4]
          expect(enum.next).to eq [2,3,4,5]
          expect(enum.next).to eq [3,4,5,6]
          expect(enum.next).to eq [4,5,6,7]
          expect(enum.next).to eq [5,6,7,8]
          expect(enum.next).to eq [6,7,8,9]
          expect(enum.next).to eq [7,8,9,10]
        end
      end
    end
  end
end
