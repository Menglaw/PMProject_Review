# Modules
PM-05 Personal AI Configuration & PM-06 AI Morning Briefing Expansion

## Objective
To enable a robust, user-configurable AI experience on the platform. This update allows users to securely save their own Gemini API keys (circumventing environment/caching issues) and dramatically improves the AI morning briefing by generating in-depth contextual analysis while exposing the raw LLM prompts for full transparency.

## Files Changed
- `backend/prisma/schema.prisma`
- `backend/src/utils/encryption.ts`
- `backend/src/controllers/user.controller.ts`
- `backend/src/controllers/dashboard.controller.ts`
- `backend/src/controllers/stockIntelligence.controller.ts`
- `backend/src/services/ai.service.ts`
- `backend/src/services/marketData.service.ts`
- `backend/test-gemini.js`
- `frontend/src/context/AuthContext.tsx`
- `frontend/src/pages/Profile.tsx`
- `frontend/src/components/dashboard/MorningBriefCard.tsx`

## Architecture Changes
- **Dynamic API Key Injection**: The backend AI services now dynamically retrieve and decrypt the requesting user's `gemini_api_key` to instantiate the `GoogleGenerativeAI` client, falling back to the global `.env` variable if none is set.
- **Model Upgrade**: Upgraded the AI model from the deprecated `gemini-2.5-flash` to the currently supported `gemini-flash-latest`.
- **Encryption Utility**: Implemented `aes-256-cbc` symmetric encryption inside `utils/encryption.ts` utilizing the existing `JWT_SECRET`.
- **Prompt Engineering**: Expanded the JSON schema requirement in the LLM prompt to generate an additional `full_briefing` paragraph, while capturing and returning the raw string prompt to the frontend.

## Database Changes
- Added `gemini_api_key String?` column to the `User` table to facilitate per-user API quotas.

## API Changes
- `GET /api/user/profile`: Now returns a securely masked `gemini_api_key` (e.g., `********e3fA`).
- `PUT /api/user/profile`: Intercepts and encrypts unmasked `gemini_api_key` inputs before committing to the DB.
- Dashboard API now returns `full_briefing` and `prompt_used` strings within the `morningBrief` object payload.

## Security Changes
- **Data at Rest**: User API keys are symmetrically encrypted inside the database.
- **Data in Transit**: Raw API keys are never transmitted back to the client.
- **Prompt Transparency**: The LLM prompt context is visible on the frontend, containing only market news and tickers, completely free of sensitive API keys or environment variables.

## UI / UX Enhancements
- Added a secure password input field in the Profile Settings under "AI Configuration".
- Transformed the "Read Full Briefing" button on the Dashboard into a fully functional trigger that opens a gorgeous glassmorphism Modal Popup.
- Introduced a collapsible accordion within the modal to reveal the exact "AI Prompt Context" to the end-user.

## Test Results
- Database schema successfully migrated via `prisma db push`.
- Dedicated `test-gemini.js` script successfully reached the Gemini API using `gemini-flash-latest`.
- Frontend and backend compile flawlessly without TypeScript or Vite errors.

## Known Issues
- None.

## Questions for ChatGPT
- Please review the newly added `MorningBriefCard` modal UI and `Profile` API key configuration flow to ensure the design aesthetic matches the rest of the application. Do you have any suggestions for micro-animations or layout adjustments within the new modal?
