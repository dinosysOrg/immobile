require 'aws-sdk'


Aws.config.update(
    endpoint: ENV['MINIO_ENDPOINT'],
    access_key_id: ENV['MINIO_KEY'],
    secret_access_key: ENV['MINIO_SECRET'],
    force_path_style: true,
    region: 'us-east-1'
)