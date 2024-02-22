FROM ubuntu:22.04

# Set working directory
WORKDIR /app

# Set noninteractive tzdata (to avoid interactive prompts) and install software-properties-common, add deadsnakes PPA, and install Python 3.10 and 3.11
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-venv python3.10-dev python3.10-distutils python3.11 python3.11-venv python3.11-dev python3.11-distutils && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2 && \
    apt-get install -y python3-pip && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install virtualenv && \
    apt-get install -y git  # Install git here

# Copy the project files into the container
COPY . /app

# Make the initialization script executable and run it
RUN chmod +x initialize_pipeline_container.sh && ./initialize_pipeline_container.sh

# Keep the container running
CMD ["tail", "-f", "/dev/null"]
