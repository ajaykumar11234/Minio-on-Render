# ======================================================
# 🧠 Combined MinIO + NGINX for Render (FINAL FIXED)
# ======================================================
FROM alpine:latest

# --- Install dependencies ---
RUN apk add --no-cache bash curl nginx minio

# --- Environment variables ---
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin

# --- Setup directories ---
RUN mkdir -p /data /etc/nginx/templates /run/nginx /etc/nginx/http.d

# --- Copy NGINX template ---
COPY nginx.conf /etc/nginx/templates/default.conf.template

# --- Expose Render’s public port dynamically ---
EXPOSE $PORT

# --- Start both MinIO and NGINX ---
CMD bash -c '\
  echo "🚀 Starting MinIO (internal) + NGINX (public, port: ${PORT})..." && \
  minio server /data --address :9000 --console-address :9001 & \
  sleep 3 && \
  sed "s/PORT_NUMBER/${PORT}/" /etc/nginx/templates/default.conf.template > /etc/nginx/http.d/default.conf && \
  nginx -g "daemon off;"'
