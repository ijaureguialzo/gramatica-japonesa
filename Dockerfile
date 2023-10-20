FROM minidocks/mkdocs

RUN apk add git

RUN pip3 install --force-reinstall git+https://github.com/ijaureguialzo/mkdocs-furigana-plugin
