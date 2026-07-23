# Module
PM-10B User Authentication & User Management

## Objective
To upgrade the authentication system into a production-quality user management module with improved security, usability, and account management, while remaining compatible with the existing architecture.

## Files Changed
- `backend/prisma/schema.prisma`
- `backend/src/controllers/auth.controller.ts`
- `backend/src/controllers/user.controller.ts`
- `backend/src/controllers/session.controller.ts` (New)
- `backend/src/controllers/audit.controller.ts` (New)
- `backend/src/routes/auth.routes.ts`
- `backend/src/routes/session.routes.ts` (New)
- `backend/src/routes/audit.routes.ts` (New)
- `backend/src/index.ts`
- `frontend/src/pages/Login.tsx`
- `frontend/src/pages/ResetPassword.tsx` (New)
- `frontend/src/pages/Profile.tsx`
- `frontend/src/App.tsx`

## Architecture Changes
- Introduced new `Session` and `AuthAuditLog` models to the Prisma schema for tracking logins and auditing events.
- Centralized new backend controllers for session management and audit logs, decoupled from general auth logic for modularity.
- Revamped the Frontend Profile page to use a tabbed interface for better navigation (General, Security, Sessions, Audit).

## Database Changes
- Modified `User` model: added `account_type`, `last_login`, `preferred_model`, `notification_prefs`, `failed_login_attempts`, `lock_until`.
- Created `Session` model with fields `device`, `browser`, `ip_address`, `login_time`, `last_activity`, `token`, `expires_at`.
- Created `AuthAuditLog` model with fields `event_type`, `ip_address`, `device`.

## API Changes
- Modified `POST /api/auth/login`: Supports `rememberMe` flag, enforces brute-force protection (lockout after 5 attempts), creates sessions and audit logs.
- Modified `POST /api/auth/forgot-password`, `POST /api/auth/reset-password`: Now write to Audit Logs.
- New `POST /api/auth/change-password`: Changes the user's password securely with validation.
- New `POST /api/auth/logout`: Revokes the current session and creates an audit log.
- New `GET /api/sessions`: Returns all active sessions for the user.
- New `DELETE /api/sessions/revoke/:sessionId`: Revokes a specific session.
- New `DELETE /api/sessions/revoke-others`: Revokes all sessions except the current one.
- New `GET /api/audit`: Returns the last 50 authentication audit logs for the user.
- Modified `GET /api/user/profile`, `PUT /api/user/profile`: Includes extended user fields.

## Security Changes
- Implemented brute-force protection: accounts temporarily lock out for 15 minutes after 5 consecutive failed login attempts.
- Added "Remember Me" functionality mapping to extended JWT expiry (30 days vs 1 day) and DB session tracking.
- Password change requires current password verification and enforces a minimum length of 8 characters.
- Comprehensive security audit log records all successful/failed logins, password changes/resets, and logouts.
- All session creations, password resets, and changes log the user's IP address and user-agent.

## Test Results
- Prisma Client successfully generated and built.
- The Admin Account seed script is verified to strictly skip overwriting existing users.

## Known Issues
- `device` parsing relies on `User-Agent` strings; in a real production environment, a user-agent parser (like `ua-parser-js`) might be needed for cleaner display in the Active Sessions UI.

## Questions for ChatGPT
None. The PM-10B module is complete!
