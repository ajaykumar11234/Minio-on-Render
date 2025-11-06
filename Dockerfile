FROM minio/minio:latest

# MinIO credentials
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin
ENV MINIO_BROWSER=on

# Render will set PORT dynamically (default 10000 for local)
ENV PORT=10000

# Expose ports (not required but useful)
EXPOSE 10000
EXPOSE 9001

# Override ENTRYPOINT so we can run a shell
ENTRYPOINT ["/bin/sh", "-c"]

# Start MinIO server and bind to Render's $PORT
CMD "minio server /data --console-address :9001 --address :${PORT}"FROM minio/minio:latest

# Set credentials
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin

# Render assigns a port but we'll default to 10000
ENV PORT=10000

# Expose both API and Console ports
EXPOSE 10000
EXPOSE 9001

# Run MinIO on Render's exposed port
ENTRYPOINT []

CMD ["sh", "-c", "minio server /data --address :10000 --console-address :9001"]

