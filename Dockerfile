FROM continuumio/miniconda3

# Install system dependencies
RUN apt-get update && \
    apt-get install -y build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# Create conda environment
RUN conda create -n myenv python=3.11 -y
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Install TA-Lib
RUN conda install -c conda-forge ta-lib -y

# Set working directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port
EXPOSE 8050

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

# Run the application
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "gunicorn", "--bind", "0.0.0.0:8050", "main:server"]
