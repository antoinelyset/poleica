# A Try a Docsplit Real Gemification
### Poleica = Polaroid + Leica (Real Hipster)


## Concept
_ -> PDF -> Image
Image    -> Image

```
Poleica.new(file_path).convert_to(:png)
Poleica.new(file_path).convert_to(:png, width: 400, weight: 400)
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