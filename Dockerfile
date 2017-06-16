FROM alpine:3.4
MAINTAINER Denys Yakymenko

#install nginx
RUN apk update && apk add nginx \
&& rm -rf /tmp/* /var/tmp/* /var/run/nginx \
&& rm -f /etc/nginx/nginx.conf && mkdir /var/run/nginx \
&& chown nginx /var/run/nginx && chmod 777 /var/run/nginx \
# forward request and error logs to docker log collector
&& ln -sf /dev/stdout /var/log/nginx/docker-access.log \
&& ln -sf /dev/stderr /var/log/nginx/docker-error.log \
&& mkdir -p /usr/share/nginx/html/405 \
&& chown -R nginx:nginx /usr/share/nginx/html/405

#copy conf
COPY nginx.def.conf /etc/nginx/conf.d/default.conf
COPY nginx1.conf    /etc/nginx/nginx.conf
COPY hello.html  /usr/share/nginx/html
COPY nohello.html /usr/share/nginx/html/405
RUN cp /etc/hosts /tmp/hosts
CMD  echo "127.0.0.1    tt0.cupemind.com" >> /etc/hosts



EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
