require_relative 'client'
require_relative 'word_frequency_counter'
require 'pry'

class WikiWordFrequencyCounter
  attr_reader :min_word_length, :page_id, :word_count, :separator, :downcase
  attr_accessor :client

  def initialize(page_id, word_count, min_word_length, downcase)
    @page_id = page_id
    @word_count = word_count
    @min_word_length = min_word_length
    @downcase = downcase

    @client = WikiClient.new
    @separator = ", "
  end

  def call
    output = []
    output << "URL: #{client.url(page_id)}"

    data = client.get(page_id)
    output << "Title: #{data[:title]}"
    output << "Top #{word_count} words: "
    word_list = extract_to_word_list(data.fetch(:extract))
    word_frequency = WordFrequencyCounter.call(word_count, word_list)

    word_frequency.each { |k, v|
      output << "- #{k}: #{v.join(separator)}"
    }
    output
  end

  def extract_to_word_list(words)
    w = words
      .gsub(/\W/, ' ') # non-whitepsace
      .split(' ') # to words
      .select{|s| s.length >= min_word_length}
    return w unless downcase
    w.map(&:downcase)
  end
end
