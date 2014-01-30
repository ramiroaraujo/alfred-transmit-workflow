#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative 'bundle/bundler/setup'
require 'alfred'
require_relative 'transmit'

query = ARGV[0]
query = query.downcase if query


Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback
  transmit = Transmit.new

  db_type = nil

  # check if xml favorites exist first
  if !transmit.check_database
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

  transmit.search(query).each do |fav|
    fb.add_item({
                    :uid => fav['uuid'],
                    :title => fav['name'],
                    :subtitle => "#{fav['username']}@#{fav['server']}",
                    :arg => fav['uuid'],
                    :valid => 'yes',
                })
  end


  # sends "no result" message
  if fb.to_xml().to_s == '<items/>'
    fb.add_item({
                    :uid => '',
                    :title => 'No results for your search',
                    :subtitle => 'Try rebuilding the Favorites cache (ftprebuild) if needed',
                    :arg => '',
                    :valid => 'no',
                })

  end

  puts fb.to_xml()
end
