ARG DSM_VERSION=6.1

FROM cwuensch/synobuild:base_${DSM_VERSION}

ARG DSM_VERSION=6.1
ARG DSM_PLATFORM=rtd1296

RUN ["/bin/sh", "-c", "wget -qO- https://downloads.sourceforge.net/project/dsgpl/toolkit/DSM${DSM_VERSION}/ds.${DSM_PLATFORM}-${DSM_VERSION}.env.txz | tar -xJhv -C build_base/"]
RUN ["/bin/sh", "-c", "wget -qO- https://downloads.sourceforge.net/project/dsgpl/toolkit/DSM${DSM_VERSION}/ds.${DSM_PLATFORM}-${DSM_VERSION}.dev.txz | tar -xJhv -C build_base/"]

RUN ["/bin/sh", "-c", "echo \"#!/bin/sh\necho\necho 'THIS CONTAINER REQUIRES docker run --privileged ARGUMENT!!'\necho\nmkdir build_env/ds.${DSM_PLATFORM}-${DSM_VERSION}\nmount --bind build_base build_env/ds.${DSM_PLATFORM}-${DSM_VERSION}\npkgscripts-ng/PkgCreate.py \\\"\\$@\\\"\" > entrypoint.sh && chmod u+x entrypoint.sh"]

ENTRYPOINT ["/toolkit/entrypoint.sh"]
