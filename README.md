# Jupyter Notebook for Pyspark

Based on image python:3.7.

A configured Jupyter notebook with a Pyspark Kernel, Livy and SparkMagic.

## Configurations

- Jupyter Notebook Configuration:

```python
c.NotebookApp.allow_root = True
c.NotebookApp.open_browser = False
c.NotebookApp.password = ''
c.NotebookApp.password_required = False
c.NotebookApp.port = 8888
c.NotebookApp.port_retries = 50
c.NotebookApp.token = ''
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.notebook_dir = 'notebook'
c.NotebookApp.pylab = 'disabled' ## DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib
```

- Java version installed: `Java 8 adoptopenjdk`
- Spark version: `2.4.7` binaries from <https://downloads.apache.org/spark/spark-2.4.7/spark-2.4.7-bin-hadoop2.7.tgz>
- Livy version: `0.7.1` binaries from <https://downloads.apache.org/incubator/livy/0.7.1-incubating/apache-livy-0.7.1-incubating-bin.zip>

## ENV variables

```bash
ENV SPARK_HOME=/opt/spark
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV LIVY_HOME=/opt/livy
ENV PATH includes SPARK_HOME/bin, SPARK_HOME/sbin  and LIVY_HOME/bin
```

## Usage

Basic usage:

```bash
docker run -it -p 8888:8888 --name pyspark-jupyter pysparkutils/jupyter-notebook
```

Previous usage will execute: `sh bin/jupyter-start.sh` which contains:

```bash
nohup livy-server start & jupyter notebook 
```
