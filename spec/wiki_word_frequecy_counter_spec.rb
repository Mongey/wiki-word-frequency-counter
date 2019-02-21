require 'spec_helper'

RSpec.describe WikiWordFrequencyCounter do
  let(:url) {"http://fakeurl"}

  context 'sucessful response' do
    let(:fake_client) {
      double(WikiClient,
             url: url,
             get: {
               title: "My Test",
               extract: "
           == hello ==
           hello world."
             })
    }

    it 'creates the expected output' do
      min_word_length = 4
      counter = WikiWordFrequencyCounter.new('123', 3, min_word_length, false)
      counter.client = fake_client

      expect(counter.call).to eq([
        "URL: #{url}",
        "Title: My Test",
        "Top 3 words: ",
        "- 2: hello",
        "- 1: world"
      ])
    end
  end

  context 'failed response' do
    let(:fake_client) {
      double(WikiClient,
             url: url,
             get: {
               title: "My Test",
               extract: "hello"})
    }

    it 'raises an exception' do
      counter = WikiWordFrequencyCounter.new('123', 3, 1, false)
      allow(HTTParty).to receive(:get).and_return(double(Hash, code: 404,
                                                         success?: false))
      expect{ counter.call }.to raise_error(StandardError)
    end
  end
end
