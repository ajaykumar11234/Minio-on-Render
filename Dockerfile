# Use official MinIO image
FROM minio/minio:latest

# Create data directory
RUN mkdir -p /data

# Expose MinIO ports
EXPOSE 9000
EXPOSE 9001

# Run MinIO server
CMD ["server", "/data", "--console-address", ":9001"]
