FROM node:20

# Set working dir
WORKDIR /app

# Copy all project files
COPY . .

# Install supervisor
RUN apt-get update && apt-get install -y supervisor

# Make script executable
RUN chmod +x start.sh

# Install serve (used by frontend)
RUN npm install -g serve

# Default command
CMD ["./start.sh"]
