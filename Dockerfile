# AUTOMATICALLY GENERATED
# DO NOT EDIT THIS FILE DIRECTLY, USE /Dockerfile.template.erb
FROM fluent/fluentd-kubernetes-daemonset:v1.13.2-debian-forward-arm64-1.0

USER root

RUN buildDeps="sudo make gcc g++ libc-dev libffi-dev" \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends $buildDeps net-tools \
    && gem install fluent-plugin-mongo \
    && gem install fluent-plugin-rabbitmq \
    && SUDO_FORCE_REMOVE=yes apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && gem sources --clear-all \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# for log storage (maybe shared with host)
RUN mkdir -p /fluentd/log
# configuration/plugins path (default: copied from .)
RUN mkdir -p /fluentd/etc /fluentd/plugins
RUN mkdir /config
 
# COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
 
ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"
 
ENV LD_PRELOAD=""
ENV DUMB_INIT_SETSID 0
EXPOSE 24224 5140
 
ENTRYPOINT ["sh", "/bin/entrypoint.sh"]
 
CMD exec fluentd -c /config/${FLUENTD_CONF}