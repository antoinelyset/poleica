# Poleica
## Opinionated ( <3 this word) thumbnail generator, heavily inspired by Docsplit
### Poleica = Polaroid + Leica (Real Hipster)


## Concept
_ -> PDF -> Image
Image    -> Image

```
Poleica.new(file_path).to_png
Poleica.new(file_path).to_png(width: 400, weight: 400)
```


## Requirements

- It should be easy
- It should work on MacOS & Linux
- It should handle standard files
- It should convert to PNG or PDF

## Standard files

- Documents: PDF, PPT, DOC, TXT
- Images: PNG, JPEG, GIF


## Conventions

- I wrote mimetype not mime_type

## Dependencies

- GraphicsMagick (gm)
- Java (I know...)
- Headless Libreoffice (for your lovely server) : [https://wiki.documentfoundation.org/Development/HeadlessBuild](https://wiki.documentfoundation.org/Development/HeadlessBuild)

## Thanks

- Webkit for their Mimetype test files