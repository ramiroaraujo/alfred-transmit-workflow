#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require 'bundle/bundler/setup'
require 'nokogiri'
require 'sqlite3'
require 'alfred'

query = ARGV[0]
query = query.downcase if query

favorites_folder = '~/Library/Application Support/Transmit/Favorites/'
favorites_sqlite = 'Favorites.sqlite'
favorites_xml = 'Favorites.xml'

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback

  db_type = nil

  # check if xml favorites exist first
  if File.exists? File.expand_path favorites_folder + favorites_xml
    db_type = 'xml'
  elsif File.exists? File.expand_path favorites_folder + favorites_sqlite
    db_type = 'sqlite'
  else
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
    exit
  end

  if db_type == 'xml'
    doc = Nokogiri::XML(File.open File.expand_path favorites_folder + favorites_xml)
    doc.xpath("//object/attribute[@name='nickname' and contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '#{query}')]/../relationship[@name='collection' and @idrefs!='z103']/..").each do |elem|
      fb.add_item({
                      :uid => elem.xpath("./attribute[@name='uuidstring']").text(),
                      :title => elem.xpath("./attribute[@name='nickname']").text(),
                      :subtitle => "#{elem.xpath("./attribute[@name='username']").text()}@#{elem.xpath("./attribute[@name='server']").text()}",
                      :arg => elem.xpath("./attribute[@name='uuidstring']").text(),
                      :valid => 'yes',
                  })
    end
  elsif db_type == 'sqlite'
    # read sqllite DB from Transmit
    db = SQLite3::Database.open File.expand_path favorites_folder + favorites_sqlite
    db.execute("select ZUUIDSTRING, ZNICKNAME, ZUSERNAME, ZSERVER from ZOBJECT where Z2_COLLECTION = 2 AND ZNICKNAME LIKE ?", "%#{query}%") do |row|
      fb.add_item({
                      :uid => row[0],
                      :title => row[1],
                      :subtitle => "#{row[2]}@#{row[3]}",
                      :arg => row[0],
                      :valid => 'yes',
                  })
    end
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
