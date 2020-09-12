ARG ECO_TAG
FROM strangeloopgames/eco-game-server:${ECO_TAG}

RUN apt update
RUN apt install -y rsync

COPY ./bin/clean.sh /usr/bin/
COPY ./bin/copy_configs.sh /usr/bin/

VOLUME ['/Configs', '/Mods']
