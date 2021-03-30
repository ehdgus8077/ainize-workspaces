# ainblockchain/workspace:openchat.dev
FROM ainblockchain/workspace:ubuntu18.04.cuda11-torch1.7


# install VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python

RUN pip install transformers==4
RUN pip install flask
RUN pip install flask_cors

ENV PASSWORD=''

# install VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python

RUN pip install transformers==4
RUN pip install flask
RUN pip install flask_cors

COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]

ENV PASSWORD=''
ENTRYPOINT "/scripts/start.sh"