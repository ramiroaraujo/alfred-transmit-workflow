require_relative 'bundle/bundler/setup'
require 'xmlsimple'
require 'sqlite3'
require 'json'

class Transmit

  def initialize
    @favorites_folder = '~/Library/Application Support/Transmit/Favorites/'
    @favorites_sqlite = 'Favorites.sqlite'
    @favorites_xml = 'Favorites.xml'

    @type = nil
  end

  def check_database
    if File.exists? File.expand_path @favorites_folder + @favorites_xml
      @type = 'xml'
      return true
    elsif File.exists? File.expand_path @favorites_folder + @favorites_sqlite
      @type = 'sqlite'
      return true
    else
      return false
    end
  end

  def search query
    cached = File.exists? 'favorites.json'
    if cached
      favorites = JSON.load IO.read 'favorites.json'
      time = favorites['time']
      totaltime = time + 10
      cached = false if (favorites['time'] + 86400) < Time.now.to_i
    end
    if !cached
      favorites = @type == 'xml' ? cache_xml : cache_sqlite
    end
    result = favorites['list'].select do |fav|
      fav['name'].downcase =~ /#{query}/ || fav['server'].downcase =~ /#{query}/
    end
    result
  end

  def rebuild_cache
    return if !check_database
    if @type == 'xml'
      cache_xml
    elsif @type == 'sqlite'
      cache_sqlite
    end
  end

  def cache_xml
    data = XmlSimple.xml_in(File.open File.expand_path @favorites_folder + @favorites_xml)['object'].select do |obj|
      obj['type'] == 'FAVORITE' && obj['relationship'][0]['name'] == 'collection' && obj['relationship'][0]['idrefs'] != 'z103'
    end

    favorites = {
        'list' => data.map do |fav|

          username = fav['attribute'].detect { |attr| attr['name'] == 'username' }
          username = username ? username['content'] : 'anonymous'
          {
              'uuid' => fav['attribute'].detect { |attr| attr['name'] == 'uuidstring' }['content'],
              'name' => fav['attribute'].detect { |attr| attr['name'] == 'nickname' }['content'],
              'server' => fav['attribute'].detect { |attr| attr['name'] == 'server' }['content'],
              'username' => username,
          }
        end
    }

    favorites['time'] = Time.now.to_i
    File.open('favorites.json', 'w') { |file| file.write(JSON.generate favorites) }
    favorites
  end

  def cache_sqlite
    favorites = {
        'time' => Time.now.to_i,
        'list' => []
    }
    db = SQLite3::Database.open File.expand_path @favorites_folder + @favorites_sqlite
    db.execute("select ZUUIDSTRING, ZNICKNAME, ZSERVER, ZUSERNAME from ZOBJECT where Z2_COLLECTION = 2") do |row|
      favorites['list'] << {
          'uuid' => row[0],
          'name' => row[1],
          'server' => row[2],
          'username' => row[3],
      }
    end
    File.open('favorites.json', 'w') { |file| file.write(JSON.generate favorites) }
    favorites
  end
end