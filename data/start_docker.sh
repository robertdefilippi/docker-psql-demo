# Shell script for starting postgres envrionment

# Replace "/Users/robert/Desktop" with the full path to your directory

# Run the postgres image
docker run \
  -v /var/lib/postgresql/data \
  -v /Users/robert/Desktop/docker-psql-demo/queries/create_table_with_data.sql:/docker-entrypoint-initdb.d/init.sql \
  -v /Users/robert/Desktop/docker-psql-demo/data:/csv-data \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=password \
  postgres:10.3

# Jump into your Docker container
# docker exec -it <containerid> bash
