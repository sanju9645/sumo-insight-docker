# Use a Debian-based Node image so we can apt-get
FROM node:20-slim

WORKDIR /app

# Install git, supervisor, and trusted CAs
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git \
      supervisor \
      ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Copy orchestrator files
COPY start.sh /app/start.sh
COPY supervisor.conf /app/supervisor.conf
COPY .env /app/.env

# Make start.sh executable
RUN chmod +x /app/start.sh

# Install 'serve' globally for frontend
RUN npm install -g serve

# Expose ports for frontend (5173) and backend (3000)
EXPOSE 5173 3000

# Launch the startup script
CMD ["/app/start.sh"]
