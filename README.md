# Poleica
## Poleica = Polaroid + Leica (Real Hipster)

[![Build Status](https://travis-ci.org/antoinelyset/poleica.png?branch=master)](https://travis-ci.org/antoinelyset/poleica)
[![Coverage Status](https://coveralls.io/repos/antoinelyset/Poleica/badge.png)](https://coveralls.io/r/antoinelyset/Poleica)
[![Code Climate](https://codeclimate.com/github/antoinelyset/Poleica.png)](https://codeclimate.com/github/antoinelyset/Poleica)
[![Gem Version](https://badge.fury.io/rb/poleica.png)](http://badge.fury.io/rb/poleica)
[![Dependency Status](https://gemnasium.com/antoinelyset/Poleica.png)](https://gemnasium.com/antoinelyset/Poleica)

## Install

__Ubuntu__ :

Look at .travis.yml file

__MacOS__ :

```
brew install ghostscript graphicsmagick
```
Download [LibreOffice](http://www.libreoffice.org/download) and install it.


__Then__ :

```
gem install poleica
```

or in __Gemfile__ :

```
gem 'poleica'
```

## Concept

_ -> PDF -> Image

Image    -> Image

## Usage

```
Poleica.new(file_path).to_png
Poleica.new(file_path).to_png(width: 400, weight: 400)
```

## Configuration

Example : 

```
Poleica.configure do |config|
  config.timeout = 2 # time in secs
  config.libre_office[:bin_paths][:linux] = '/usr/local/bin/gm'
  config.graphics_magick[:bin_paths][:osx] = '/Applications/OpenOffice.app/Contents/MacOS/soffice.bin'
```

## Options

- weight       : pixels number
- width        : pixels number
- force_resize : boolean(false) (it doesnt preserve the image ratio)
- thumbnail    : boolean(false) (it crops the image, preserving the image ratio)
- path         : string folder or file
- auto_orient  : boolean(true) (keep the orientation extracted from EXIF)

## Dependencies

- GraphicsMagick (gm) >= 1.3.18 (for auto-rotate)
- LibreOffice 

## Requirements

- It should be easy
- It should work on MacOS & Linux
- It should handle standard files
- It should convert to PNG or PDF

## Standard files

- Documents: PDF, PPT, DOC, TXT..
- Images: PNG, JPEG, GIF...

## Conventions

- I wrote mimetype not mime_type

## Warning

- Exit LibreOffice App before tests and launch

## Thanks

- A lot of inspiration from a lot of gems :
  - Docsplit
  - Paperclip
  - ROM
  - ...

## License

Poleica is released under the [MIT
License](http://www.opensource.org/licenses/MIT)
