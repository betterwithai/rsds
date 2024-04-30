# Use an official Rust image
FROM rust:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy the source code into the container
COPY . .

# Build the application
RUN RUSTFLAGS="-C target-cpu=native" cargo build --release

# Set the path to the built executable
ENV PATH="/usr/src/app/target/release:${PATH}"

# Command to run when the container starts
CMD ["rsds-scheduler"]
