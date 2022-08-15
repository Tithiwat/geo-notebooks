# Copyright ©2021. Element 84, Inc. All Rights Reserved.
FROM jupyter/scipy-notebook:latest

LABEL maintainer="Matthew Hanson <matt.a.hanson@gmail.com>"

USER ${NB_UID}

COPY environment.yml /opt/conda/environment.yml
RUN mamba env update -p /opt/conda --file /opt/conda/environment.yml \
    && mamba clean --all -f -y

COPY dask.yaml /home/jovyan/.config/dask/dask.yaml

RUN pip install --extra-index-url="https://packages.dea.ga.gov.au" \
  odc-ui \
  odc-stac \
  odc-stats \
  odc-algo \
  odc-io \
  odc-cloud[ASYNC] \
  odc-dscache

ENV \
  GDAL_DISABLE_READDIR_ON_OPEN=EMPTY_DIR

