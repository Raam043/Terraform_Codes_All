https://cloudgeeks.ca

# Docker Nginx S3 Proxy

Have S3 objects in a private bucket that you want to serve via nginx

## Environment Variables
- `ACCESS_KEY` - AWS Access Key
- `SECRET_KEY` - AWS Secret Key
- `BUCKET` - the bucket name
- `PREFIX` - a prefix to prepend to every key. (useful if you want to limit access to specific keys). optional.

## Usage:
```
docker run -e BUCKET=some_bucket -e PREFIX=key/prefix/ -e ACCESS_KEY=someKey -e SECRET_KEY=someSecret -p 80:80
```

# Private S3 Bucket with S3 Service User/Limited Priviledges 
Example:

docker build -t quickbooks2018/s3-reverse-proxy:latest .

docker run --name s3-private-bucket-reverse-proxy -e BUCKET=cloudgeeks-ca -e ACCESS_KEY=AKIA5VC32LF7K5QURUWC -e SECRET_KEY=oKnRvwYc8IHRGe3xK2IVUg6hfnCBzzPGb88RUq9j -p 80:80 --restart unless-stopped -id quickbooks2018/s3-reverse-proxy:latest


# Ref https://github.com/orgs/ficusio/packages
# Ref https://github.com/ficusio/openresty