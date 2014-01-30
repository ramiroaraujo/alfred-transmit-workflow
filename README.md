# Transmit 4 Workflow for Alfred app

Workflow for searching and opening Favorites in Transmit 4 App. It's really _fast_, because it reads the SQLite Database or XML datasource in latests releases of Transmit 4.

There are already at least 2 Transmit workflows, but one is incompatible with latests Transmit 4 and the other, although very good, uses AppleScript to do the searching, and thus you need to wait for Transmit to open to get feedback. This is particulary slow on non SSD machines.

## Usage
Type the keyword (default _ftp_) and start typing the name of the favorite to search; dead simple.

![search](https://raw.github.com/ramiroaraujo/alfred-transmit-workflow/master/screenshots/search.png)

## Installation
For OS X 10.9 Mavericks, Download the [alfred-transmit-workflow.alfredworkflow](https://github.com/ramiroaraujo/alfred-transmit-workflow/raw/master/alfred-transmit-workflow.alfredworkflow) and import to Alfred 2.

For Previous OS X Versions, Download the [alfred-transmit-workflow.alfredworkflow](https://github.com/ramiroaraujo/alfred-transmit-workflow/raw/pre-mavericks/alfred-transmit-workflow.alfredworkflow) and import to Alfred 2.

## Changelog
* _2013-12-16_ - Released
* _2014-01-02_ - Added support for previous OS versions, using System Ruby 1.8, tested up to Lion
* _2014-01-03_ - Search in both Favorite name and host
* _2014-01-20_ - Added support for Favorites.xml
* _2014-01-30_ - Rebuilt XML search to use different Ruby xml parser