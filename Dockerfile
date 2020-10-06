FROM ubuntu:bionic
RUN apt-get update -y
# Timezone configuration is required to avoid tzdata interuption while installing packages.
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get -y install software-properties-common build-essential python-dev python-pip git unzip wget
RUN add-apt-repository ppa:freecad-maintainers/freecad-daily
RUN apt-get update -y
RUN apt install -y freecad
COPY . .
RUN pip install -r requirements.txt
RUN mkdir /root/.FreeCAD && wget https://github.com/yorikvanhavre/Draft-dxf-importer/archive/1.39.zip && unzip 1.39.zip && cp Draft-dxf-importer-1.39/* /root/.FreeCAD/
CMD [ "./kb_builder.py" ]
