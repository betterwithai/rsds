# Use an official Rust image
FROM rust:latest

# Install Python, pip, and venv
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Set the working directory
WORKDIR /usr/src/app

# Create a Python virtual environment
RUN python3 -m venv venv

# Activate virtual environment
ENV PATH="/usr/src/app/venv/bin:$PATH"

# Copy the source code into the container
COPY . .

# Upgrade pip and install the specific version of Dask within the virtual environment
RUN pip install --upgrade pip && pip install git+https://github.com/Kobzol/distributed@simplified-encoding

# Build the application
RUN RUSTFLAGS="-C target-cpu=native" cargo build --release

# Set the path to the built executable
ENV PATH="/usr/src/app/target/release:${PATH}"

# Command to run when the container starts
CMD ["rsds-scheduler"]
