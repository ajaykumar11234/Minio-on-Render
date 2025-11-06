# Use the official MinIO image
FROM minio/minio:latest

# --- Environment Variables ---
# Render injects $PORT dynamically; default 10000 for local runs
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin
ENV PORT=10000

# --- Expose only one port (Render’s public port) ---
EXPOSE 10000

# --- Run both MinIO API and Console on the same Render port ---
# The trick: Console runs on /minio, API stays at root
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["minio server /data --address :${PORT} --console-address :${PORT}"]
