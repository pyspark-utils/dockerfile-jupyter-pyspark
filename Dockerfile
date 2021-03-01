FROM python:3.7

WORKDIR /root

# INSTALL JAVA via SDK-MAN
RUN apt update
RUN apt install zip
RUN apt install unzip
RUN apt-get install software-properties-common -y
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
RUN apt-get update && apt-get install adoptopenjdk-8-hotspot -y

# INSTALL SPARK
RUN wget https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz
RUN tar xvf spark-*
RUN mv spark-2.4.7-bin-hadoop2.7 /opt/spark

ENV SPARK_HOME=/opt/spark
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PATH=${PATH}:${SPARK_HOME}/bin:${SPARK_HOME}/sbin

# INSTALL LIVY
RUN wget https://downloads.apache.org/incubator/livy/0.7.1-incubating/apache-livy-0.7.1-incubating-bin.zip
RUN unzip apache-livy-0.7.1-incubating-bin.zip
RUN mv apache-livy-0.7.1-incubating-bin /opt/livy
ENV LIVY_HOME=/opt/livy
ENV PATH=${PATH}:${LIVY_HOME}/bin

# INSTALL JUPYTER with SPARK/SPARKMAGIC
RUN pip install jupyter
RUN pip install sparkmagic
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension 
RUN jupyter-kernelspec install /usr/local/lib/python3.7/site-packages/sparkmagic/kernels/sparkkernel
RUN jupyter-kernelspec install /usr/local/lib/python3.7/site-packages/sparkmagic/kernels/pysparkkernel
RUN jupyter-kernelspec install /usr/local/lib/python3.7/site-packages/sparkmagic/kernels/sparkrkernel
RUN jupyter serverextension enable --py sparkmagic
COPY .sparkmagic .sparkmagic
COPY .jupyter/jupyter_notebook_config.json ./.jupyter/jupyter_notebook_config.json
COPY .jupyter/jupyter_notebook_config.py ./.jupyter/jupyter_notebook_config.py
# CREATE NOTEBOOK FOLDER TO STORE notes as configured in jupyter_notebook_config.py (c.NotebookApp.notebook_dir = 'notebook')
RUN mkdir notebook


# START LIVY AND JUPYTER NOTEBOOK
COPY bin/jupyter-start.sh ./bin/jupyter-start.sh
CMD ["sh", "bin/jupyter-start.sh"]