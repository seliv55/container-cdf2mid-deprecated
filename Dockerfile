# PhenoMeNal H2020

FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase:v3.4.1-1xenial0_cv0.2.12

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL maintainer="PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )"
LABEL version="1.0"
LABEL software.version="1.0"
LABEL software="simid"
LABEL description="Reads CDF files containing multiple mass spectra of 13C-labeled metabolites, and write the extracted spectra in a format exchangeable with Metabilights database."
LABEL website="https://github.com/seliv55/simid"
LABEL documentation="https://github.com/phnmnl/container-simid/blob/master/README.md"
LABEL license="https://github.com/phnmnl/container-simid/blob/develop/License.txt"
LABEL license="https://github.com/phnmnl/container-simid/blob/master/License.txt"
LABEL tags="Metabolomics"

ENV simid_REVISION "446cf14d4055133f936018f40c4520a547fe4074"

# Setup package repos
RUN apt-get -y update && apt-get -y --no-install-recommends install r-base-dev libssl-dev \
                                    libcurl4-openssl-dev git \
                                    libssh2-1-dev r-cran-ncdf4 && \
    echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site && \
    R -e "install.packages(c('devtools', 'optparse'))" && \
    R -e 'library(devtools); install_github("seliv55/simid",ref=Sys.getenv("simid_REVISION")[1])' && \
    apt-get purge -y git r-base-dev libssl-dev libcurl4-openssl-dev libssh2-1-dev && \
    apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Add scripts folder to container
ADD scripts/runsimid.R /usr/bin/runsimid.R
RUN chmod +x /usr/bin/runsimid.R

# Add test scripts
ADD simidTest1.sh /usr/local/bin/simidTest1.sh
RUN chmod a+x /usr/local/bin/simidTest1.sh
# Define Entry point script
ENTRYPOINT ["runsimid.R"]

