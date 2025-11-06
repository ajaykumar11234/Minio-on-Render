# Use official MinIO image
FROM minio/minio:latest

# --- Credentials ---
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin

# --- Render's dynamic port (default for local) ---
ENV PORT=9001

# --- Expose only the console port (Render scans this) ---
EXPOSE 9001

# --- Run MinIO API internally on 9000, Console on Render's $PORT ---
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["minio server /data --address :9000 --console-address :${PORT}"]
