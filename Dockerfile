FROM python:3.6.15

RUN apt-get update

RUN apt-get install -y libleptonica-dev

RUN apt-get update -y &&\
    apt-get install automake &&\
    apt-get install -y pkg-config &&\
    apt-get install -y libsdl-pango-dev &&\
    apt-get install -y libicu-dev &&\
    apt-get install -y libcairo2-dev &&\
    apt-get install bc

RUN apt-get install git &&\
    git clone https://github.com/tesseract-ocr/tesseract &&\
    wget https://github.com/tesseract-ocr/tesseract/archive/refs/tags/5.0.1.zip &&\
    apt-get install unzip &&\
    unzip 5.0.1

RUN cd tesseract-5.0.1 &&\
    ./autogen.sh &&\
    ./configure &&\
    make &&\
    make install &&\
    ldconfig &&\
    make training &&\
    make training-install

RUN wget https://github.com/tesseract-ocr/tessdata/blob/master/eng.traineddata -P /usr/local/share/tessdata &&\ 
    wget https://github.com/tesseract-ocr/tessdata/blob/master/osd.traineddata -P /usr/local/share/tessdata &&\
    wget https://github.com/tesseract-ocr/tessdata/blob/master/por.traineddata -P /usr/local/share/tessdata

ENV TESSDATA_PREFIX=/usr/local/share/tessdata
