# Module
PM-05 Personal AI Configuration

## Objective
Allow users to securely store and utilize their own personal Gemini API Key directly from their Profile settings to circumvent environment variable caching/restart issues and to support multi-user quotas.

## Files Changed
- `backend/prisma/schema.prisma`
- `backend/src/utils/encryption.ts`
- `backend/src/controllers/user.controller.ts`
- `backend/src/controllers/dashboard.controller.ts`
- `backend/src/controllers/stockIntelligence.controller.ts`
- `backend/src/services/ai.service.ts`
- `backend/src/services/marketData.service.ts`
- `frontend/src/context/AuthContext.tsx`
- `frontend/src/pages/Profile.tsx`

## Architecture Changes
- Backend now supports dynamic API key injection into the `GoogleGenerativeAI` client on a per-request basis.
- Created `utils/encryption.ts` implementing `aes-256-cbc` using the existing `JWT_SECRET` as the cryptographic key, ensuring raw API keys are never stored in plain text.
- Fallback logic: The AI service uses the `userApiKey` parameter if provided, falling back to the global `process.env.GEMINI_API_KEY`.

## Database Changes
- Added `gemini_api_key String?` column to the `User` table.

## API Changes
- `GET /api/user/profile` now returns a masked `gemini_api_key` if one exists (e.g., `********e3fA`).
- `PUT /api/user/profile` now accepts `gemini_api_key`. If it doesn't begin with `********`, it intercepts and encrypts it before updating the database.

## Security Changes
- User API keys are symmetrically encrypted at rest.
- The raw API key is never transmitted back to the client via API responses.

## Test Results
- Frontend and backend compile successfully without TypeScript errors.
- Schema successfully pushed to the local PostgreSQL database via Docker.

## Known Issues
- None.

## Questions for ChatGPT
- None.
