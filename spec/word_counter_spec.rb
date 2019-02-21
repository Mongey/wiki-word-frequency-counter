require 'spec_helper'

RSpec.describe WordFrequencyCounter do
  it 'returns the correct number of ' do
    sut = described_class.call(3, %w(hello hello hello hello world world world hi hi hi hey hey hey oh hai))

    expect(sut).to eq({
      4 => ["hello"],
      3 => ["world", "hi", "hey"],
      1 => ["oh", "hai"]
    })
  end
end
