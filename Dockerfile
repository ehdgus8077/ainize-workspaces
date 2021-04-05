# everytime
FROM ainblockchain/workspace:ubuntu18.04.cuda11-torch1.7

# install VS Code
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python

# install ttyd
WORKDIR /
RUN wget https://github.com/tsl0922/ttyd/archive/refs/tags/1.6.2.zip
RUN unzip 1.6.2.zip
RUN cd ttyd-1.6.2 && mkdir build && cd build && cmake .. && make && sudo make install
COPY start.sh /scripts/start.sh
RUN ["chmod", "+x", "/scripts/start.sh"]

RUN pip install transformers==2.11.0
RUN pip install sentencepiece

RUN curl -c /tmp/cookies "https://drive.google.com/uc?export=download&id=1wLcmouRAskQiRC99mdMxj6pii7EEvb9i" > /tmp/intermezzo.html
RUN curl -L -b /tmp/cookies "https://drive.google.com$(cat /tmp/intermezzo.html | grep -Po 'uc-download-link" [^>]* href="\K[^"]*' | sed 's/\&amp;/\&/g')" > /workspace/every_gpt.pt

RUN URL="https://drive.google.com/uc?export=download&id=$id"
RUN wget --no-check-certificate "https://docs.google.com/uc?export=download&id=19t6_Cn6qPM7HEq23zbeMQdeKtqGcEz73" -O /workspace/kogpt2_news_wiki_ko_cased_818bfa919d.spiece

WORKDIR /workspace
ENV PASSWORD=''
ENTRYPOINT "/scripts/start.sh"