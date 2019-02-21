require 'thor'
require_relative 'wiki_word_frequency_counter'

LOGGER = Logger.new(STDERR)
STACK_OVERFLOW_WIKI_PAGE_ID = 21721040

DEFAULT_WIKI_PAGE_ID = STACK_OVERFLOW_WIKI_PAGE_ID
DEFAULT_WORD_COUNT = 5
DEFAULT_WORD_LENGTH = 4

class CLI < Thor
  default_task :fetch

  desc "fetch", "Get the word frequency count from a given Wiki page"
  option :page_id, default: DEFAULT_WIKI_PAGE_ID, type: :numeric, desc: 'The page id of the wikipedia page you want to count'
  option :downcase, default: true, type: :boolean, desc: 'Downcase all words before counting, so that HELLO == hello'
  option :count, default: DEFAULT_WORD_COUNT, type: :numeric, desc: 'The number of words you want to retrieve'
  option :min_word_length, default: DEFAULT_WORD_LENGTH, type: :numeric, desc: 'The minimum size word to consider'
  option :debug, default: false, type: :boolean

  def fetch
    LOGGER.level = options[:debug] ? Logger::DEBUG : Logger::WARN
    LOGGER.debug(options)
    begin
      output = WikiWordFrequencyCounter.new(options[:page_id],
                                            options[:count],
                                            options[:min_word_length],
                                            options[:downcase]).call
      puts output.join("\n")
    rescue StandardError => e
      LOGGER.error(e)
      exit(1)
    end
  end
end
