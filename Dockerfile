FROM nginx:alpine
COPY site /usr/share/nginx/html
RUN printf '%s\n' \
    'server {' \
    '    listen 80;' \
    '    listen [::]:80;' \
    '    server_name _;' \
    '    root /usr/share/nginx/html;' \
    '    index index.html;' \
    '    absolute_redirect off;' \
    '    location = /aca-filing-software { return 301 /; }' \
    '    location ^~ /aca-filing-software/ { return 301 /; }' \
    '    location / { try_files $uri $uri/ =404; }' \
    '}' > /etc/nginx/conf.d/default.conf \
    && nginx -t
