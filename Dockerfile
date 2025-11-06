# Use official MinIO image
FROM minio/minio:latest

# Set environment variables
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin

# Expose default MinIO API and Console ports (optional)
EXPOSE 9000
EXPOSE 9001

# Run MinIO and bind to Render's assigned port
CMD minio server /data --console-address ":9001" --address ":${PORT}"
