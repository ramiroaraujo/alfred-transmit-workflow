#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require "sqlite3"
require "alfred"

query = ARGV[0]

favorites = '~/Library/Application Support/Transmit/Favorites/Favorites.sqlite'

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback

  # check if database exists
  if !File.exists? File.expand_path favorites
    fb.add_item({
                    :uid => '',
                    :title => 'No Transmit Database found!',
                    :arg => '',
                    :valid => 'no',
                    :icon => {
                        :type => "default",
                        :name => "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns"
                    }
                })

    puts fb.to_xml()
    return
  end

  # read sqllite DB from Transmit
  db = SQLite3::Database.open(File.expand_path favorites)
  db.execute("select ZUUIDSTRING, ZNICKNAME, ZUSERNAME, ZSERVER from ZOBJECT where Z2_COLLECTION = 2 AND ZNICKNAME LIKE ?", "%#{query}%") do |row|
    fb.add_item({
                    :uid => row[0],
                    :title => row[1],
                    :subtitle => "#{row[2]}@#{row[3]}",
                    :arg => row[0],
                    :valid => 'yes',
                })
  end

  # sends "no result" message
  if fb.to_xml().to_s == '<items/>'
    fb.add_item({
                    :uid => '',
                    :title => 'No results for your search',
                    :arg => '',
                    :valid => 'no',
                })

  end

  puts fb.to_xml()
end
