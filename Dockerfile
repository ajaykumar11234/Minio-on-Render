# Use the official MinIO image
FROM minio/minio:latest

# Set MinIO credentials
ENV MINIO_ROOT_USER=minioadmin
ENV MINIO_ROOT_PASSWORD=minioadmin

# Render automatically assigns a port, but we set a default for local dev
ENV PORT=10000

# Expose ports (optional, helps Render detect networking)
EXPOSE 10000
EXPOSE 9001

# Start MinIO bound to Render's dynamic port
CMD sh -c 'minio server /data --console-address ":9001" --address ":${PORT}"'
