# Transmit 4 Workflow for Alfred app

Workflow for searching and opening Favorites in Transmit 4 App. It's really _fast_, because it reads the SQLite Database
in latests releases of Transmit 4.

There are already at least 2 Transmit workflows, but one is incompatible with latests Transmit 4 and the other, although very good, uses AppleScript to do the searching, and thus you need to wait for Transmit to open to get feedback. This is particulary slow on non SSD machines.

## Usage
Type the keyword (default _ftp_) and start typing the name of the favorite to search; dead simple.


![search](https://raw.github.com/ramiroaraujo/alfred-transmit-workflow/master/screenshots/search.png)


## OS Version
OSX 10.9 Mavericks only, since the SQLite3 gem has native extensions, built with OSX Ruby 2 version.

## Installation
Download the [alfred-transmit-workflow.alfredworkflow](https://github.com/ramiroaraujo/alfred-transmit-workflow/raw/master/alfred-transmit-workflow.alfredworkflow) and import to Alfred 2.