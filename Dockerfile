# ======================================================
# 🧠 Combined MinIO + NGINX for Render
# ======================================================
FROM alpine:latest

# --- Install dependencies ---
RUN apk add --no-cache minio nginx bash curl

# --- Environment variables ---
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin
ENV PORT=9000

# --- Setup directories ---
RUN mkdir -p /data /etc/nginx/templates

# --- Copy NGINX template ---
COPY nginx.conf /etc/nginx/templates/default.conf.template

# --- Expose Render public port ---
EXPOSE 9000

# --- Start both MinIO + NGINX ---
CMD bash -c '\
  minio server /data --address :${PORT} --console-address :9001 & \
  sleep 3 && \
  sed "s/PORT_NUMBER/${PORT}/" /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && \
  nginx -g "daemon off;"'
