FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget git build-essential

RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y erlang

# ENSURE UTF-8
RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN echo "set nocompatible" > /root/.vimrc

WORKDIR /tmp/elixir-build
RUN git clone https://github.com/elixir-lang/elixir.git
WORKDIR elixir
RUN git checkout @ELIXIR_VERSION@ && make && make install

ADD webapp /opt/webapp
WORKDIR /opt/webapp

ENV MIX_ENV prod
ENV PORT 80

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile
RUN mix compile.protocols
RUN elixir -pa _build/prod/consolidated -S mix phoenix.routes

CMD elixir -pa _build/prod/consolidated -S mix phoenix.start

EXPOSE 80
EXPOSE 443