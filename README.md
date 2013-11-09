QuoteFetcher
=========

Fetches quotes from iheartquotes.com. Also ensures no duplicates will end up in the database.

Requires
-------

  - MongoDB with the MongoDB Ruby driver
  - open-uri gem
  - A terminal

Usage
-----
- 'ruby quotes.rb <number of quotes to fetch>'

or

- Run as a fake daemon with: 'nohup ruby quotes.rb <number of quotes to fetch> &'
