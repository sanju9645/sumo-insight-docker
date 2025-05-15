# sumo-insight-docker/start.sh
#!/bin/sh
set -e

echo "🔄 Checking repositories..."

if [ ! -d "frontend" ]; then
  echo "📦 Cloning frontend repo..."
  git clone https://github.com/sanju9645/sumo-insight-frontend.git frontend
else
  echo "🔁 Pulling latest frontend..."
  cd frontend && git pull && cd ..
fi

if [ ! -d "backend" ]; then
  echo "📦 Cloning backend repo..."
  git clone https://github.com/sanju9645/sumo-insight-backend.git backend
else
  echo "🔁 Pulling latest backend..."
  cd backend && git pull && cd ..
fi

echo "⚙️ Setting up environment variables..."
export $(grep -v '^#' .env | xargs)

echo "📦 Installing and building frontend..."
cd frontend
npm install
npm run build
cd ..

echo "📦 Installing backend..."
cd backend
npm install
npm run build || true
cd ..

echo "🚀 Starting app via Supervisor..."
exec supervisord -c /app/supervisor.conf
