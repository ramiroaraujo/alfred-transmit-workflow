# Transmit 4 Workflow for Alfred app

Workflow for searching, opening and/or mounting Favorites in Transmit 4 App. It's really _fast_, because it reads the SQLite Database or XML datasource in latests releases of Transmit 4.

There are already at least 2 Transmit workflows, but one is incompatible with latests Transmit 4 and the other, although very good, uses AppleScript to do the searching, and thus you need to wait for Transmit to open to get feedback. This is particulary slow on non SSD machines.

## Usage
**Connect** - Type the keyword (default _ftp_) and start typing the name of the favorite to search; dead simple.

![search](https://raw.github.com/ramiroaraujo/alfred-transmit-workflow/master/screenshots/search.png)

**Mount** - Type the keyword (default _ftpmount_) and start typing the name of the favorite to mount as a Transmit Disk.

## Installation
For OS X 10.9 Mavericks, Download the [alfred-transmit.alfredworkflow](https://github.com/ramiroaraujo/alfred-transmit-workflow/raw/master/alfred-transmit.alfredworkflow) and import to Alfred 2.

For Previous OS X Versions, Download the [alfred-transmit.alfredworkflow](https://github.com/ramiroaraujo/alfred-transmit-workflow/raw/pre-mavericks/alfred-transmit.alfredworkflow) and import to Alfred 2.

## Changelog
* _2013-12-16_ - Released
* _2014-01-02_ - Added support for previous OS versions, using System Ruby 1.8, tested up to Lion
* _2014-01-03_ - Search in both Favorite name and host
* _2014-01-20_ - Added support for Favorites.xml
* _2014-01-30_ - Rebuilt XML search to use different Ruby xml parser
* _2014-03-14_ - Corrected bug that prevented listing of anonymous ftp accounts
* _2015-01-15_ - George Böhnisch - Added the ability to mount a favorite as a Transmit Disk