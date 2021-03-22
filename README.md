to generate sample files with fonts in custom

``` docker run -v C:/Users/julie/Documents/GitHub/tesstrain/out/images:/app/code/trdg/out/ -v C:/Users/julie/Documents/GitHub/tesstrain/out/font:/app/code/trdg/trdg/fonts/custom/  -t tesstrain:test /env/bin/python -m trdg.run -c 200 -rs -num -na 3 -e png -o /app/code/tesstrain/data/new_model-ground-truth -fd /app/code/trdg/trdg/fonts/custom/ ```

``` docker run -v path-to-images:/app/code/trdg/out/ -v path-to-fonts:/app/code/trdg/trdg/fonts/custom/  -t tesstrain:test /env/bin/python -m trdg.run -c 200 -rs -num -na 3 -e png -fd /app/code/trdg/trdg/fonts/custom/ ```

``` docker run -v C:/Users/julie/Documents/GitHub/tesstrain/out/images:/app/code/tesstrain/data/new_model-ground-truth -v C:/Users/julie/Documents/GitHub/tesstrain/out/font:/app/code/trdg/trdg/fonts/custom/ -v C:/Users/julie/Documents/GitHub/tesstrain/out/model:/app/code/tesstrain/data/new_model -v C:/Users/julie/Documents/GitHub/tesstrain/out/new_model.traineddata:/app/code/tesstrain/data/new_model.traineddata -e NUM_IMG=500 -e IMG_FMT=tif -e IMG_TYPE=RGB -e START_MODEL=eng -t tesstrain:latest ```  

``` docker run -v C:/Users/julie/Documents/GitHub/tesstrain/out/images:/app/code/tesstrain/data/new_model-ground-truth -v C:/Users/julie/Documents/GitHub/tesstrain/out/font:/app/code/trdg trdg/fonts/custom/ -v C:/Users/julie/Documents/GitHub/tesstrain/out/model:/app/code/tesstrain/data/new_model -v C:/Users/julie/Documents/GitHub/tesstrain/out/new_model.traineddata:/app/code/tesstrain/data/new_model.traineddata -e START_MODEL=frk -t tesstrain:justTrain``` 

Envirronment variables :
- NUM_IMG : number of images to create
- IMG_FMT : extension for the images (png, jpg, tif)
- IMG_TYPE : Define the image mode to be used. RGB is default, L means 8-bit grayscale images, 1 means 1-bit binary images stored with one pixel per byte...
- START_MODEL: language to start training from (defaut eng)
