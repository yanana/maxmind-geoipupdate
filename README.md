# geoipupdate

[![Docker Repository on Quay](https://quay.io/repository/tkrs/maxmind-geoipupdate/status "Docker Repository on Quay")](https://quay.io/repository/tkrs/maxmind-geoipupdate)

## Usage

### Pull an image

```
docker pull tkrs/maxmind-geoipupdate
```

### Run the image

Simply run `docker run`. You can also customize the behaviour by passing environment variables. Available variables are [here](#variables).
```
docker run -d -e GEOIP_DB_DIR=/data/GeoIP tkrs/geoipupdate
```

### Variables

- *GEOIP_DB_DIR*: The directory to store the database files. Defaults to "/usr/local/share/GeoIP".
- *MAXMIND_HOST*: The server to use. Defaults to "updates.maxmind.com".
- *PROTOCOL*: The desired protocol either "https" (default) or "http".
