# custom cinder-volume container - having python-3parclient
FROM registry.redhat.io/rhosp-rhel8/openstack-cinder-volume:16.2

MAINTAINER HPE

LABEL name="rhosp16/openstack-cinder-volume-hpe" \
      maintainer="sneha.rai@hpe.com" \
      vendor="HPE" \
      version="2.0" \
      release="16" \
      summary="Red Hat OpenStack Platform 16.2 cinder-volume HPE plugin" \
      description="Cinder plugin for HPE 3PAR"

# switch to root and install a custom RPM, etc.
USER "root"

# install python module python-3parclient(dependent module for HPE 3PAR Cinder driver)
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python3 get-pip.py && pip3 install -U setuptools && pip3 install python-3parclient==4.2.11 && rm get-pip.py

RUN mkdir -p /licenses

# Add required license as text file in Liceses directory (GPL, MIT, APACHE, Partner End User Agreement, etc)
COPY LICENSE /licenses

# switch the container back to the default user
USER "cinder"
