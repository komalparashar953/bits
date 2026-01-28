FROM node:18-alpine

WORKDIR /app

# Copy root package files
COPY package.json ./

# Install backend dependencies
RUN npm install

# Copy backend code
COPY server.js ./
COPY backend ./backend

# Setup frontend build
WORKDIR /app/frontend
COPY frontend/package.json ./
RUN npm install
COPY frontend ./
RUN npm run build

# Go back to root
WORKDIR /app

# Serve frontend static files from backend
# We need to modify server.js slightly to serve these files if we want a single container
# Or we can just run the backend and assume frontend is handled elsewhere, 
# but "Level 1 Challenge" usually implies a single deliverable.
# Let's assume we will modify server.js to serve the 'dist' folder.

EXPOSE 3001

CMD ["node", "server.js"]
