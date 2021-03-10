to generate sample files with fonts in custom

``` docker run -v C:/Users/julie/Documents/GitHub/tesstrain/out/images:/app/out/ -v C:/Users/julie/Documents/GitHub/tesstrain/out/font:/app/trdg/fonts/custom/  -t trdg:latest trdg -c 200 -rs -num -na 3 -e png -fd -o /app/ trdg/fonts/custom/ ```