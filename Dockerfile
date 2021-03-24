# ainblockchain/workspace:openchat.dev
FROM ainblockchain/workspace:ubuntu18.04.cuda11-torch1.7


# install VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python

RUN pip install transformers==4
RUN pip install flask
RUN pip install flask_cors

ENV PASSWORD=''
ENTRYPOINT jupyter notebook  --NotebookApp.token=$PASSWORD --ip=0.0.0.0 --port=8000 --allow-root --NotebookApp.notebook_dir=$WORKSPACE_HOME & ttyd -p 8020 /bin/bash & code-server --bind-addr=0.0.0.0:8010 --auth none