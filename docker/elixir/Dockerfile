FROM alpine:latest

ENV ELIXIR_VERSION 1.4.1

RUN apk --update --no-cache add ncurses-libs git make g++ wget python ca-certificates openssl nodejs \
                     erlang erlang-dev erlang-kernel erlang-hipe erlang-compiler \
                     erlang-stdlib erlang-erts erlang-tools erlang-syntax-tools erlang-sasl \
                     erlang-crypto erlang-public-key erlang-ssl erlang-ssh erlang-asn1 erlang-inets \
                     erlang-inets erlang-mnesia erlang-odbc erlang-xmerl \
                     erlang-erl-interface erlang-parsetools erlang-eunit && \
    update-ca-certificates --fresh && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    rm -rf /var/cache/apk/*


ENV PATH $PATH:node_modules/.bin:/opt/elixir-${ELIXIR_VERSION}/bin

RUN mix local.hex --force && \
	mix local.rebar --force  && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

CMD ["iex"]