# ainblockchain/workspace:nipa
FROM ainblockchain/workspace:ubuntu18.04.cuda11-torch1.7

# install VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python

RUN pip install transformers==4.4.2
RUN pip install flask
RUN pip install flask_cors
RUN pip install openchat==1.0

WORKDIR /
RUN wget https://github.com/tsl0922/ttyd/archive/refs/tags/1.6.2.zip
RUN unzip 1.6.2.zip
RUN cd ttyd-1.6.2 && mkdir build && cd build && cmake .. && make && sudo make install

COPY start.sh /scripts/start.sh
COPY handlers.py $HOME/.jupyter/handlers.py
COPY jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py
COPY main.js /opt/conda/lib/python3.7/site-packages/notebook/static/tree/js/main.js
COPY tree.html /opt/conda/lib/python3.7/site-packages/notebook/templates/tree.html
COPY notebook.html /opt/conda/lib/python3.7/site-packages/notebook/templates/notebook.html

RUN ["chmod", "+x", "/scripts/start.sh"]

WORKDIR /workspace
ENV PASSWORD=''
ENTRYPOINT "/scripts/start.sh"