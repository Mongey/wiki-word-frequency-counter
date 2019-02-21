class WordFrequencyCounter
  def self.call(number_of_words_to_find, words)
    new().call(number_of_words_to_find, words)
  end

  # Input number_of_words_to_find: Int -> number of word frequencies to find
  # Returns a hash, keyed & ordered by frequency count: [words]
  # e.g: { 10: ["hello", "world"], 9: ["homer"]}
  def call(number_of_words_to_find, words)
    # returns a hash of {word => occurances}
    word_freq = words.each_with_object(Hash.new(0)) {|w, h| h[w] +=1}
    # see what lengths we need
    counts_to_find = word_freq.values.uniq.sort.reverse.take(number_of_words_to_find)

    # init the hash so that it's sorted
    counted_words = counts_to_find.each_with_object(Hash.new([])) { |i, h|
      h[i] = []
    }

    word_freq.each { |word, count|
      counted_words[count] << word if counts_to_find.include?(count)
    }
    counted_words
  end
end
