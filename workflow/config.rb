#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative "bundle/bundler/setup"
require "yaml"
require "alfred"

Alfred.with_friendly_error do |alfred|

  fb = alfred.feedback

  fb.add_item({
                  :uid => "",
                  :title => "No Sync configured",
                  :subtitle => "Transmit is not configured to sync it's Favorites",
                  :arg => "library",
                  :valid => "yes",
              })
  fb.add_item({
                  :uid => "",
                  :title => "Sync via Dropbox",
                  :subtitle => "Transmit is configured to sync it's Favorites via Dropbox",
                  :arg => "dropbox",
                  :valid => "yes",
              })

  puts fb.to_xml()
end
