# dbt-testing-demo
Demo Repo for dbt Testing Functionality

## Running the Demo

### System Requirements
The following packages and tools were used to build this demo. 

| requirement | version used | purpose |
|--|--|--|
|docker|20.10.14|Containerized PostgreSQL database|
|python|3.9.6|required for dbt and virtual environments|
|dbt core|1.5.2|Develop/run data pipelines. 1.5.0 is the minimum required|
|dbt-postgres|1.5.2|Used for integration with PostgreSQL|


### Start PostgreSQL & pgAdmin
On a command prompt, navigate to the `docker/postgresql` directory start the PostgreSQL docker container by running `docker compose up`.

This will do the following:  
1. Start a PostgreSQL docker container
1. Load PostgreSQL db with initial data
1. Start pgAdmin as a web interface for postgres

### Setting up pgAdmin to Query Data
The creation of the connection from pgAdmin to postgres is not automated yet.  Here are the steps to set up a connection.

1. Open a browser and navigate to [http://localhost:5050/](http://localhost:5050/)
1. Log in with the username/password listed in [docker/postgresql/docker-compose.yml](./docker/postgresql/docker-compose.yml)  
   ```yaml
    PGADMIN_DEFAULT_EMAIL: admin@admin.com
    PGADMIN_DEFAULT_PASSWORD: root
    ```
1. In Object Explorer, right-click `Servers`, then `Register`, then `Server` and enter the following details and then click save:
   * General Tab
     * Name: `local`
   * Connection
     * Host name/address: `pgdatabase`
     * Username: `postgres`
     * Password: `ITsC0mpl1cat3d`

Now, you should see the `local` database server. Within the database, you will see three (3) tables under Databases/postgres/Schemas/bronze/Tables.