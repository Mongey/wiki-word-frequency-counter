require 'httparty'

class WikiClient
  BASE_URL = "https://en.wikipedia.org/w/api.php"

  def get(page)
    page = page.to_s
    result = HTTParty.get(url(page))
    raise StandardError.new(result.code) unless result.success?

    resp = result.parsed_response
    data = resp.dig('query', 'pages', page)

    {
      title: data.fetch('title', ''),
      extract: data.fetch('extract', ''),
    }
  end

  def url(page)
    "#{BASE_URL}?action=query&prop=extracts&explaintext&format=json&pageids=#{page}"
  end
end
