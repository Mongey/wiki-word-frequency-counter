# Wiki Word Frequency Counter

Displays the most frequent words on a given wikipedia page

# :runner: Running
`./wiki-word-freq fetch`

```
Usage:
  wiki-word-freq fetch

Options:
  [--page-id=N]                  # The page id of the wikipedia page you want to count
                                 # Default: 21721040
  [--downcase], [--no-downcase]  # Downcase all words before counting, so that HELLO == hello
                                 # Default: true
  [--count=N]                    # The number of words you want to retrieve
                                 # Default: 5
  [--min-word-length=N]          # The minimum size word to consider
                                 # Default: 4
  [--debug], [--no-debug]
```

## Sample output

```
./wiki-word-freq fetch --count=7 --page_id=1023011 --min_word_length=6
URL: https://en.wikipedia.org/w/api.php?action=query&prop=extracts&explaintext&format=json&pageids=1023011
Title: Allen's rule
Top 7 words:
- 11: animals
- 9: surface, temperature
- 7: climates, volume
- 6: shorter, populations, predictions
- 5: different, ratios, temperatures, height
- 4: should, lengths, people, originate, regions, warmer, steegman, raised
- 3: adapted, predicts, because, argued, indigenous, species, colder, growth, cartilage, degrees
```

# :hammer: Development
0. `bundle install`
0. `bundle exec rspec`

