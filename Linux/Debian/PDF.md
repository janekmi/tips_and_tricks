# PDF

## From Markdown

```sh
pandoc input.md -o output.pdf --pdf-engine=xelatex -V mainfont="DejaVu Sans" -V geometry:margin=0.5
```

**Note**: `--pdf-engine=xelatex` although optional allows to extra syntax.

### Extra syntax

- `\newpage`

## Size reduction (GhostScript)

```sh
gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -o smaller.pdf output.pdf
```
