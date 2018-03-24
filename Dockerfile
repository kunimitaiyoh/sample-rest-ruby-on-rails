FROM ruby:2.5

RUN gem install rails

RUN mkdir /usr/src/forums
WORKDIR /usr/src/forums
COPY Gemfile /usr/src/forums
RUN bundle install
COPY . /usr/src/forums

CMD ["rails", "server"]
