FROM ruby:2.5.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# ルート直下にsample_dockerという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /sample_docker
WORKDIR /sample_docker

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /sample_docker/Gemfile
ADD Gemfile.lock /sample_docker/Gemfile.lock

# bundle installの実行
RUN bundle install


# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /sample_docker

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
#RUN mkdir -p tmp/sockets
#RUN mkdir -p tmp/pids
RUN mkdir -p tmp/pids
RUN rm -f /sample_docker/tmp/pids/server.pid

