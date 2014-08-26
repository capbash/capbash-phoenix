FROM elixir_@ELIXIR_VERSION@

ADD webapp /opt/webapp
WORKDIR /opt/webapp

ENV MIX_ENV prod
ENV PORT 80
ENV PROXY_PORT @PHOENIX_PROXY_PORT@

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile
RUN mix compile.protocols
RUN elixir -pa _build/prod/consolidated -S mix phoenix.routes

CMD elixir -pa _build/prod/consolidated -S mix phoenix.start

EXPOSE 80
EXPOSE 443