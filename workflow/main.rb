#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative "bundle/bundler/setup"
require "sqlite3"
require "alfred"

query = ARGV[0]

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback

  # read sqllite DB from Transmit
  db = SQLite3::Database.open (File.expand_path '~/Dropbox/apps/transmit/favorites/Favorites.sqlite')
  db.execute("select ZUUIDSTRING, ZNICKNAME, ZUSERNAME, ZSERVER from ZOBJECT where Z2_COLLECTION = 2 AND ZNICKNAME LIKE ?", "%#{query}%") do |row|
    fb.add_item({
                    :uid => row[0],
                    :title => row[1],
                    :subtitle => "#{row[2]}@#{row[3]}",
                    :arg => row[0],
                    :valid => "yes",
                })
  end
  if fb.to_xml().to_s == '<items/>'
    fb.add_item({
                    :uid => '',
                    :title => 'No results for your search',
                    :arg => '',
                    :valid => "no",
                })

  end

  puts fb.to_xml()
end
