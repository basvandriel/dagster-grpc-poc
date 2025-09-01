# Local Setup for Dagster GRPC Server

This guide will help you build and run the Dagster GRPC server locally using Docker, and configure your environment for Dagster.

---

### 1. Set up the `DAGSTER_HOME` environment variable

Add the following line to your `~/.bashrc` (or `~/.zshrc` if you use zsh):

```bash
export DAGSTER_HOME=~/dagster_home
```

---

### 2. Create the Dagster home directory

Create the directory if it doesn't exist:

```bash
mkdir -p $DAGSTER_HOME
chmod 777 $DAGSTER_HOME
```

---

### 3. Copy the sample configuration

Copy the Dagster example instance configuration file to your Dagster home:

```bash
cp dagster_example.yaml $DAGSTER_HOME/dagster.yaml
```

---

### 4. Build the Docker Image

From the project root directory, build the Docker image:

```bash
docker build -t dagster-grpc-server .

# or using podman
podman build -t dagster-grpc-server .
```


---

### 5. Run the GRPC Server Container

Run the container and mount your Dagster home directory:

```bash
docker run -p 4266:4266 -v $DAGSTER_HOME:/dagster_home dagster-grpc-server

# or using podman
podman run -p 4266:4266 -v $DAGSTER_HOME:/dagster_home dagster-grpc-server
```


**Why do we need to mount `DAGSTER_HOME`?**

Mounting your local `DAGSTER_HOME` directory into the container ensures that Dagster's configuration, logs, and storage are persisted outside the container. This allows you to:
- Share configuration and state between multiple Dagster components (GRPC server, webserver, daemon).
- Avoid losing important files when the container is stopped or rebuilt.
- Easily inspect logs and configuration from your host system.

---

### 6. Test the GRPC Server

The Dagster GRPC server should now be running and accessible at `localhost:4266`.

You can connect to it from Dagster tools (webserver, daemon, etc.) by specifying the GRPC server address.