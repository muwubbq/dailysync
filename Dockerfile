FROM node:lts-alpine3.19
RUN apk add --no-cache curl ca-certificates tzdata
ARG TARGETARCH
RUN curl -L -o /usr/local/bin/supercronic \
  https://github.com/aptible/supercronic/releases/download/v0.2.38/supercronic-linux-${TARGETARCH} \
  && chmod +x /usr/local/bin/supercronic
WORKDIR /app
ENV TZ=Asia/Shanghai
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []
