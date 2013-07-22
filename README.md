# Poleica
## Poleica = Polaroid + Leica (Real Hipster)

[![Build Status](https://travis-ci.org/antoinelyset/Poleica.png?branch=master)](https://travis-ci.org/antoinelyset/Poleica)
[![Coverage Status](https://coveralls.io/repos/antoinelyset/Poleica/badge.png)](https://coveralls.io/r/antoinelyset/Poleica)
[![Code Climate](https://codeclimate.com/github/antoinelyset/Poleica.png)](https://codeclimate.com/github/antoinelyset/Poleica)
[![Dependency Status](https://gemnasium.com/antoinelyset/Poleica.png)](https://gemnasium.com/antoinelyset/Poleica)

## Concept

_ -> PDF -> Image

Image    -> Image

```
Poleica.new(file_path).to_png
Poleica.new(file_path).to_png(width: 400, weight: 400)
```

## Options

- weight: pixel
- width:  pixel
- path:   folder or file

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

## Dependencies

- GraphicsMagick (gm)
- Java (I know...)
- LibreOffice 

## Thanks

- A lot of inspiration from a lot of gems :
  - Docsplit
  - Paperclip
  - ROM
  - ...

## License

Poleica is released under the [MIT
License](http://www.opensource.org/licenses/MIT)
