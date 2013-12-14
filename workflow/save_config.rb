# procedural app that changes the workflow config to use the dropbox or library favorites database

require 'yaml'

dropbox_path = '~/Dropbox/apps/transmit/favorites/Favorites.sqlite'
library_path = '~/Library/Application Support/Transmit/Favorites/Favorites.sqlite'

query = ARGV[0]

config = YAML.load_file('config.yml')

case query
  when 'library'
    config['path'] = library_path
  when 'dropbox'
    config['path'] = dropbox_path
  else
    exit
end

File.open('config.yml', "wb") { |file| file.write(YAML.dump config) }