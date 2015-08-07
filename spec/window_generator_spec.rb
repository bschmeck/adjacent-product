require_relative "../window_generator.rb"

RSpec.describe WindowGenerator do
  let(:digits) { (1..10).to_a.shuffle }
  let(:window_size) { 4 }

  subject(:generator) { WindowGenerator.new digits, window_size }

  describe "#via" do
    it "fails for unknown strategies" do
      expect { generator.via(:foobar) }.to raise_error(ArgumentError)
    end

    WindowGenerator::STRATEGIES.each do |strategy|
      context "when strategy is #{strategy}" do
        it "yields each window to a given block" do
          # 10 digits = 7 windows
          count = 0
          generator.via(strategy) { count += 1 }
          expect(count).to eq 7
        end

        it "yields unique objects" do
          expect(generator.via(strategy).to_a.uniq.count).to eq 7
        end
      end
    end
  end
end
