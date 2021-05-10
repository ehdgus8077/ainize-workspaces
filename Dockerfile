# openchat
FROM ainblockchain/workspace:ubuntu18.04.cuda11-torch1.7

# install VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-toolsai.jupyter

RUN pip install transformers==4.4.2
RUN pip install flask
RUN pip install flask_cors
RUN pip install openchat==1.0
RUN pip install ipywidgets



WORKDIR /
RUN wget https://github.com/tsl0922/ttyd/archive/refs/tags/1.6.2.zip
RUN unzip 1.6.2.zip
RUN cd ttyd-1.6.2 && mkdir build && cd build && cmake .. && make && sudo make install
COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]

COPY jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py
COPY login.html /opt/conda/lib/python3.7/site-packages/notebook/templates/login.html


WORKDIR /workspace
ENV PASSWORD=''
ENTRYPOINT "/scripts/start.sh"