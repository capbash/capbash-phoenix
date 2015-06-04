FROM elixir:@ELIXIR_VERSION@

# Install Node.js, Ruby and inotify
RUN \
  apt-get update && \
  apt-get -yf install && \
  apt-get install -y curl inotify-tools && \
  curl -sL https://deb.nodesource.com/setup | sudo bash - && \
  apt-get install -y nodejs build-essential ruby1.9.3 && \
  gem install sass

# Install postgres
# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
ENV LANG en_US.utf8
ENV PG_MAJOR @POSTGRES_MAJOR@
ENV PG_VERSION @POSTGRES_VERSION@

RUN \
  groupadd -r postgres && useradd -r -g postgres postgres && \
  apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
  apt-key adv --keyserver pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
  echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list && \
  apt-get update && \
  apt-get install -y postgresql-common && \
  sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
  apt-get install -y \
    postgresql-$PG_MAJOR=$PG_VERSION \
    postgresql-contrib-$PG_MAJOR=$PG_VERSION && \
  rm -rf /var/lib/apt/lists/*

ADD src/phoenix_new-@PHOENIX_INTERNAL_VERSION@.ez /opt/phoenix/
WORKDIR /opt/phoenix
RUN \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix archive.install --force /opt/phoenix/phoenix_new-@PHOENIX_INTERNAL_VERSION@.ez

ADD bin /usr/local/dockerbin

ENV PATH /usr/local/dockerbin:node_modules/.bin:/usr/lib/postgresql/$PG_MAJOR/bin:$PATH
WORKDIR /src

