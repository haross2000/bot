FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pre-built TA-Lib
RUN curl -L -o /tmp/ta-lib-0.4.0-src.tar.gz http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
    && cd /tmp \
    && tar xvfz ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib \
    && sed -i.bak "s|0.00000001|0.000000001|g" src/ta_func/ta_utility.h \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && cd .. \
    && rm -rf ta-lib-0.4.0-src.tar.gz ta-lib \
    && cd /

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir numpy==1.26.2 \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port
EXPOSE 8050

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8050", "main:server"]
