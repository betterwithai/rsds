# Use an official Rust image
FROM rust:latest

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Set the working directory
WORKDIR /usr/src/app

# Copy the source code into the container
COPY . .

# Install the specific version of Dask
RUN pip install git+https://github.com/Kobzol/distributed@simplified-encoding

# Build the application
RUN RUSTFLAGS="-C target-cpu=native" cargo build --release

# Set the path to the built executable
ENV PATH="/usr/src/app/target/release:${PATH}"

# Command to run when the container starts
CMD ["rsds-scheduler"]
