FROM elixir_@ELIXIR_VERSION@

ADD webapp /opt/webapp
WORKDIR /opt/webapp

ENV MIX_ENV prod
ENV PORT 80
EXPOSE 80
EXPOSE 443

ENV PROXY_PORT @PHOENIX_PROXY_PORT@

RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get && \
  mix compile && \
  mix compile.protocols && \
  elixir -pa _build/prod/consolidated -S mix phoenix.routes

CMD elixir -pa _build/prod/consolidated -S mix phoenix.start
