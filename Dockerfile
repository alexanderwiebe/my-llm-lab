FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set up workspace
WORKDIR /workspace

# Copy source code in early
COPY . .

# Upgrade pip and install Python packages as root
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Create a user for VS Code
RUN useradd -m vscode
USER vscode

# Ensure ~/.local/bin is in PATH for the vscode user
RUN echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
