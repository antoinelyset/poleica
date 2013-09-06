#!/bin/bash
/usr/lib/libreoffice/program/soffice.bin --nologo --headless --invisible --norestore --nolockcheck --convert-to pdf test/support/files/example.doc
rm example.pdf
exit 0
