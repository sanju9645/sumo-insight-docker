# sumo-insight-docker

Turning raw API data into actionable intelligence

## ✅ Build & Run

**Build** your image:

```bash
docker build -t sanju/sumo-insight-docker . 
```

**Run** with your `.env`:

```bash
docker run --env-file .env -p 5173:5173 -p 3000:3000 sanju/sumo-insight-docker
```

---

## 📦 Pushing to Docker Hub

If you want to share this:

```bash
docker tag sanju/sumo-insight-docker sanju9645/sumo-insight-docker:latest
docker login
docker push sanju9645/sumo-insight-docker:latest
```

Then others can:

```bash
docker pull sanju9645/sumo-insight-docker:latest

docker run -d --env-file .env -p 5173:5173 -p 3000:3000 sanju9645/sumo-insight-docker:latest
docker run -d --name sumo-insight-docker --env-file .env -p 5173:5173 -p 3000:3000 --restart unless-stopped sanju9645/sumo-insight-docker:latest

```


# sumo-insight 🚀

Turning raw API data into actionable intelligence

You can find the source code here:

* Frontend: [https://github.com/sanju9645/sumo-insight-frontend](https://github.com/sanju9645/sumo-insight-frontend)
* Backend:  [https://github.com/sanju9645/sumo-insight-backend](https://github.com/sanju9645/sumo-insight-backend)
* Docker wrapper: [https://github.com/sanju9645/sumo-insight-docker](https://github.com/sanju9645/sumo-insight-docker)

---

## 🛠️ Quickstart

---

## 🔐 Authentication & Database Configuration

This project uses **Auth0** for user authentication and **MongoDB** as the primary database.

### 🔑 Setting Up Auth0

To enable secure login functionality using Auth0, follow these steps:

1. **Create an Auth0 Account**

   * Go to [https://auth0.com](https://auth0.com) and sign up or log in.

2. **Create an Auth0 Application**

   * Navigate to the **Applications → Applications** section in the Auth0 dashboard.
   * Click **Create Application**.
   * Choose a name (e.g., `sumo-insight-client`) and select the **Single Page Web Applications** type.
   * Click **Create**.

3. **Configure Allowed URLs**

   * Under the application settings:

     * **Allowed Callback URLs**:
       `http://localhost:5173`
     * **Allowed Logout URLs**:
       `http://localhost:5173`
     * **Allowed Web Origins**:
       `http://localhost:5173`

4. **Create an API in Auth0**

   * Navigate to **Applications → APIs**.
   * Click **Create API**.
   * Choose a name like `sumo-insight-api`.
   * Set an identifier, e.g., `sumo-insight`.
   * Leave signing algorithm as **RS256** and click **Create**.

### ⚙️ Required Environment Variables

In your `.env` file (placed in the root of your Docker setup), set the following:

#### For Frontend (Vite)

```env
VITE_API_BASE_URL=http://localhost:3000

VITE_AUTH0_DOMAIN=<your-auth0-domain>
VITE_AUTH0_CLIENT_ID=<your-auth0-client-id>
VITE_AUTH0_CALLBACK_URL=http://localhost:5173
VITE_AUTH0_AUDIENCE=sumo-insight
```

* **VITE\_AUTH0\_DOMAIN**: Found in your Auth0 tenant settings (e.g., `dev-xxxxx.us.auth0.com`).
* **VITE\_AUTH0\_CLIENT\_ID**: Found in the Application Settings.
* **VITE\_AUTH0\_CALLBACK\_URL**: Must match the value configured in Auth0 → Application.
* **VITE\_AUTH0\_AUDIENCE**: Should be the API identifier (e.g., `sumo-insight`).

#### For Backend

```env
PORT=3000
FRONTEND_PORT=5173

NODE_ENV=development

MONGODB_CONNECTION_STRING=<your-mongodb-connection-string>
AUTH0_AUDIENCE=sumo-insight
AUTH0_ISSUER_BASE_URL=https://<your-auth0-domain>/
```

* **MONGODB\_CONNECTION\_STRING**: Your MongoDB URI (e.g., `mongodb+srv://<user>:<pass>@cluster.mongodb.net/dbname`).
* **AUTH0\_AUDIENCE**: Must match the API Identifier created in Auth0.
* **AUTH0\_ISSUER\_BASE\_URL**: This is `https://<your-auth0-domain>/`.

### 👤 Logging In

Once set up:

* Navigate to `http://localhost:5173`.
* Click **Login**.
* You’ll be redirected to Auth0’s secure login page.
* After successful login, you'll be redirected back to your application with an access token used to communicate securely with the backend.

---



### 1. Create a `.env` file in the root of **sumo-insight-docker**

```dotenv
# Frontend (Vite)
VITE_API_BASE_URL=http://localhost:3000
VITE_AUTH0_DOMAIN=<vite_auth0_domain>
VITE_AUTH0_CLIENT_ID=<vite_auth0_client_id>
VITE_AUTH0_CALLBACK_URL=http://localhost:5173
VITE_AUTH0_AUDIENCE=sumo-insight

# Ports
PORT=3000
FRONTEND_PORT=5173

# Environment
NODE_ENV=development

# 🍃 MongoDB Configuration
MONGODB_CONNECTION_STRING=<mongodb-connection-string>

# 🔐 Auth0
AUTH0_AUDIENCE=<auth0-audience>
AUTH0_ISSUER_BASE_URL=<auth0-issuer-base-url>

# 📊 API Analysis Tables
API_ANALYSIS_TABLE_NAME_DEV=<api-analysis-table-name-dev>
API_ANALYSIS_TABLE_NAME_PROD=<api-analysis-table-name-prod>
API_ANALYSIS_ENDPOINT_CLASSIFICATION_TABLE_NAME_DEV=<api-analysis-endpoint-classification-table-name-dev>
API_ANALYSIS_ENDPOINT_CLASSIFICATION_TABLE_NAME_PROD=<api-analysis-endpoint-classification-table-name-prod>

# 👥 Admin Access
ADMIN_EMAILS=<admin-emails>

# 📈 Sumo Logic
SUMO_BASE_URL=<sumo-base-url>
SUMO_ACCESS_ID=<sumo-access-id>
SUMO_ACCESS_KEY=<sumo-access-key>

# 📬 Google Mailer
SMTP_USER=<smtp-user>
SMTP_PASS=<smtp-pass>

# 🤗 Hugging Face
HUGGINGFACE_API_KEY=<huggingface-api-key>
HUGGINGFACE_MODEL=<huggingface-model>

# 📞 Twilio
TWILIO_ACCOUNT_SID=<twilio-account-sid>
TWILIO_AUTH_TOKEN=<twilio-auth-token>
TWILIO_PHONE_NUMBER=<twilio-phone-number>

# 🛡️ API Masking
API_REWRITE_MAP=<json-api-rewrite-map>

# 🔍 DeepSeek
DEEP_SEEK_API_KEY=<deepseek-api-key>
DEEP_SEEK_URL=<deepseek-url>

# 🧠 OpenAI
OPEN_AI_KEY=<openai-key>
```

### 2. Pull the image

```bash
docker pull sanju9645/sumo-insight-docker:latest
```

### 3. Run the container

```bash
docker run -d \
  --env-file .env \
  -p 5173:5173 \
  -p 3000:3000 \
  sanju9645/sumo-insight-docker:latest
```

### 4. (Optional) Name and auto-restart

```bash
docker run -d \
  --name sumo-insight-docker \
  --env-file .env \
  -p 5173:5173 \
  -p 3000:3000 \
  --restart unless-stopped \
  sanju9645/sumo-insight-docker:latest
```

### 5. Stop the container

```bash
docker stop sumo-insight-docker
```

### 6. Remove the container

```bash
docker rm sumo-insight-docker
```

### 7. Start the container

```bash
docker start sumo-insight-docker
```

### 8. Restart the container

```bash
docker restart sumo-insight-docker
```

### 9. View logs

```bash
docker logs sumo-insight-docker
```

---

## 🐳 Recommended: Docker Compose

Instead of long `docker run` commands, use this `docker-compose.yml`:

```yaml
version: '3.8'

services:
  app:
    image: sanju9645/sumo-insight-docker:latest
    container_name: sumo-insight-docker
    env_file:
      - .env
    ports:
      - "5173:5173"
      - "3000:3000"
    restart: unless-stopped
```

Then simply:

1. **Start** the service

   ```bash
   docker-compose up -d
   ```

2. **Stop** the service

   ```bash
   docker-compose down
   ```


3. **View logs**

   ```bash
   docker-compose logs -f
   ```

