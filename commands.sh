#!/bin/bash
/env/bin/python -m trdg.run -c $NUM_IMG -rs -num -na 3 -e $IMG_FMT -r -im 1 --output_dir /app/code/tesstrain/data/new_model-ground-truth -fd /app/code/trdg/trdg/fonts/custom/
cd /app/code/tesstrain
make training MODEL_NAME=new_model OUTPUT_DIR=/app/code/tesstrain/data/new_model
# make traineddata MODEL_NAME=new_model OUTPUT_DIR=/app/code/tesstrain/data/new_model
