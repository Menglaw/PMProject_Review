# Module
PM-01 User Authentication

## Objective
To provide a secure, scalable, and premium authentication flow for the Project Millionaire platform, allowing new users to register, login, recover their passwords, and manage their profiles.

## Files Changed
- `backend/src/controllers/auth.controller.ts`
- `backend/src/controllers/user.controller.ts`
- `backend/src/middlewares/auth.middleware.ts`
- `backend/prisma/schema.prisma`
- `frontend/src/pages/Login.tsx`
- `frontend/src/pages/Register.tsx`
- `frontend/src/pages/ForgotPassword.tsx`
- `frontend/src/pages/Profile.tsx`
- `frontend/src/context/AuthContext.tsx`
- `frontend/src/services/api.ts`

## Architecture Changes
- Set up a Node.js Express backend with Prisma ORM.
- Set up a Vite React + TypeScript frontend with Tailwind CSS.
- Implemented a Context API-based state management system for authentication on the frontend.
- Designed a scalable routing structure with PrivateRoute guards.

## Database Changes
- Initialized PostgreSQL database via Docker.
- Created `User` table with fields for UUID, full_name, email, password_hash, country, currency, timezone, and timestamps.
- Wrote a Prisma seed script (`seed.ts`) to automatically generate a default admin user.

## API Changes
- `POST /api/auth/register`: Registers a new user.
- `POST /api/auth/login`: Authenticates users and returns a JWT.
- `POST /api/auth/forgot-password`: Mocks sending a password reset email.
- `POST /api/auth/reset-password`: Resets a user's password using a valid token.
- `GET /api/user/profile`: Fetches the currently authenticated user's profile.
- `PUT /api/user/profile`: Updates the user's profile settings (country, currency, timezone, etc.).

## Security Changes
- Passwords are never stored in plaintext (using `bcrypt` with 10 salt rounds).
- Authentication is handled securely via JWT (JSON Web Tokens).
- Implemented `express-rate-limit` on the login route (max 10 requests per 15 minutes per IP) to prevent brute force attacks.
- Prevented email enumeration in the forgot password endpoint by always returning a generic success message.

## Test Results
- ✅ User Registration succeeds and auto-logs in.
- ✅ Login validates credentials against hashed entries.
- ✅ Profile data fetches correctly when authenticated.
- ✅ Editing and saving profile details successfully persists to PostgreSQL.
- ✅ Mocked forgot password flow successfully outputs the token in the backend console.

## Known Issues
- Forgot Password flow currently logs the link to the console instead of sending an actual email (Mock mode as per requirements).
- Reset Password UI screen has not been fully designed yet since the token is currently just logged in the backend.

## Questions for ChatGPT
- Should we integrate Nodemailer or Resend for the Forgot Password flow in the next module, or keep it mocked for now?
- When PM-02 Dashboard begins, should the dashboard be the default landing page upon login instead of the profile page?
