# Poleica
## Poleica = Polaroid + Leica (Real Hipster)

[![Build Status](https://travis-ci.org/antoinelyset/poleica.png?branch=master)](https://travis-ci.org/antoinelyset/poleica)
[![Coverage Status](https://coveralls.io/repos/antoinelyset/Poleica/badge.png)](https://coveralls.io/r/antoinelyset/Poleica)
[![Code Climate](https://codeclimate.com/github/antoinelyset/Poleica.png)](https://codeclimate.com/github/antoinelyset/Poleica)
[![Dependency Status](https://gemnasium.com/antoinelyset/Poleica.png)](https://gemnasium.com/antoinelyset/Poleica)

## Install

__Ubuntu__ :

```
apt-get install graphicsmagick libreoffice
```

__MacOS__ :

```
brew install graphicsmagick
```

__Then__ :

```
gem install poleica
```

or in __Gemfile__ :

```
gem 'poleica'
```

Then download [LibreOffice](http://www.libreoffice.org/download) and install it.
## Concept

_ -> PDF -> Image

Image    -> Image

## Usage

```
Poleica.new(file_path).to_png
Poleica.new(file_path).to_png(width: 400, weight: 400)
```

## Options

- weight: pixel
- width:  pixel
- path:   folder or file
- force_resize: boolean (it doesnt preserve the image ratio)
- thumbnail : boolean (it crops the image the given weight and width,
  preserving the image ratio)

## Dependencies

- GraphicsMagick (gm)
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
