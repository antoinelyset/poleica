FROM phusion/passenger-ruby21:0.9.15

RUN apt-get update -qq && apt-get install -qq libreoffice wget build-essential ghostscript
RUN wget http://78.108.103.11/MIRROR/ftp/GraphicsMagick/1.3/GraphicsMagick-1.3.20.tar.gz
RUN tar -xvf GraphicsMagick-1.3.20.tar.gz
RUN cd GraphicsMagick-1.3.20 && ./configure && make && make install

ADD . /poleica
WORKDIR /poleica
RUN bundle install
