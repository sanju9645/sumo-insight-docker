#!/bin/bash

set -e

echo "🔄 Checking repositories..."

if [ ! -d "frontend" ]; then
  echo "📦 Cloning frontend repo..."
  git clone https://github.com/your-org/sumo-insight-frontend.git frontend
else
  echo "🔁 Pulling latest frontend..."
  cd frontend && git pull && cd ..
fi

if [ ! -d "backend" ]; then
  echo "📦 Cloning backend repo..."
  git clone https://github.com/your-org/sumo-insight-backend.git backend
else
  echo "🔁 Pulling latest backend..."
  cd backend && git pull && cd ..
fi

echo "⚙️ Setting up environment variables..."

# Export .env vars
export $(grep -v '^#' .env | xargs)

# Write frontend env
cat <<EOF > frontend/.env
VITE_API_BASE_URL=http://localhost:${BACKEND_PORT}
VITE_AUTH0_DOMAIN=$VITE_AUTH0_DOMAIN
VITE_AUTH0_CLIENT_ID=$VITE_AUTH0_CLIENT_ID
VITE_AUTH0_CALLBACK_URL=http://localhost:${FRONTEND_PORT}
VITE_AUTH0_AUDIENCE=$VITE_AUTH0_AUDIENCE
EOF

# Copy backend env
cp .env backend/.env

echo "📦 Installing and building frontend..."
cd frontend
npm install
npm run build
cd ..

echo "📦 Installing backend..."
cd backend
npm install
npm run build || true  # Ignore if no build step
cd ..

echo "🚀 Starting app via Supervisor..."
exec supervisord -c /app/supervisor.conf
