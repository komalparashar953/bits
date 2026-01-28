# Live Bidding Platform

A real-time auction platform built with Node.js, Socket.io, and React.

## Features

- **Real-Time Bidding**: Instant bid updates via WebSockets.
- **Concurrency Handling**: Atomic bid processing ensures race conditions are handled gracefully.
- **Time Synchronization**: Client timers are synced with server time to prevent exploitation.
- **Premium UI**: Dark mode design with visual feedback for events (outbid/winning).
- **Dockerized**: Ready for deployment.

## Prerequisites

- Node.js v16+ (or Docker)
- npm

## Getting Started

### Local Development

1. **Install Dependencies**
   ```bash
   npm install
   cd frontend && npm install && cd ..
   ```

2. **Build Frontend**
   ```bash
   cd frontend
   npm run build
   cd ..
   ```

3. **Start Server**
   ```bash
   npm start
   # Or directly: node server.js
   ```
   The application will be available at `http://localhost:3001`.

### Docker Deployment

1. **Build and Run**
   ```bash
   docker build -t bidding-platform .
   docker run -p 3001:3001 bidding-platform
   ```
   Access at `http://localhost:3001`.

## Architecture Highlights

- **Backend**: Express + Socket.IO.
  - `auctionService.js`: Contains business logic and synchronous `placeBid` function to handle race conditions in the Node.js event loop.
- **Frontend**: React + Vite.
  - Custom CSS Design System (`designSystem.css`).
  - Optimistic UI updates with authoritative correction from server.
- **Concurrency Testing**:
  - Run the test script: `node backend/tests/concurrency.js` (Requires server running).

## Race Condition Strategy

The platform relies on Node.js's single-threaded event loop for write operations. The `placeBid` function is synchronous, ensuring that no two requests can modify the auction state simultaneously. This acts as a natural mutex for in-memory operations.

## Level 1 Challenge Status

- [x] Backend (Node + Socket.io)
- [x] Frontend (React)
- [x] Race Condition Handling
- [x] Time Synchronization
- [x] Dockerfile
