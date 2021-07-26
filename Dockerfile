FROM registry.access.redhat.com/ubi8/go-toolset AS builder

USER root

ENV PKG=/go/src/github.com/Jooho/pachyderm-operator-test-harness/
WORKDIR ${PKG}
RUN chmod -R 755 ${PKG}

# compile test binary
COPY . .
RUN make

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

RUN mkdir -p ${HOME} &&\
    chown 1001:0 ${HOME} &&\
    chmod ug+rwx ${HOME}

RUN mkdir -p /test-run-results &&\
    chown 1001:0 /test-run-results &&\
    chmod ug+rwx /test-run-results

COPY --from=builder /go/src/github.com/Jooho/pachyderm-operator-test-harness/operator-test-harness.test  operator-test-harness.test

COPY template/manifests-test-job.yaml /home/manifests-test-job.yaml

RUN chmod +x operator-test-harness.test

ENTRYPOINT [ "/operator-test-harness.test" ]

USER 1001