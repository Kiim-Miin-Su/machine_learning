docker run -it --rm -p 8888:8888 \
-v $(pwd):/app -v ${HOME}/.jupyter:/root/.jupyter:ro -w /app \
univ_chosun_ml:latest \
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root