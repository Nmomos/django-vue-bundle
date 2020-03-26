FROM ubuntu:18.04

ENV PYTHON_VERSION 3.8.2
ENV HOME /root
ENV PYTHON_ROOT $HOME/local/python-$PYTHON_VERSION
ENV PATH $PYTHON_ROOT/bin:$PATH
ENV PYENV_ROOT $HOME/.pyenv
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app
COPY ./frontend/package*.json ./frontend/
COPY requirements.txt /app/

RUN apt-get update && apt-get upgrade -y \
 && apt-get install -y -f\
    git \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
 # Installing Nodejs and npm from NVM
 && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
 && export NVM_DIR="$HOME/.nvm" \
 && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
 && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
 && nvm install node \
 && npm --prefix ./frontend install ./frontend \
 # Installing Python and Pyenv
 && git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
 && $PYENV_ROOT/plugins/python-build/install.sh \
 && /usr/local/bin/python-build $PYTHON_VERSION $PYTHON_ROOT \
 && rm -rf $PYENV_ROOT \
 && pip install --upgrade pip && pip install -r requirements.txt \
 && python manage.py migrate

COPY . .
