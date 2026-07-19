# Module
PM-06 AI Morning Briefing Expansion

## Objective
Make the "Read Full Briefing" feature functional by generating an in-depth AI briefing and exposing the underlying LLM prompt to the user via a collapsible UI to increase transparency.

## Files Changed
- `backend/src/services/ai.service.ts`
- `frontend/src/components/dashboard/MorningBriefCard.tsx`

## Architecture Changes
- No structural changes. `ai.service.ts` now requests an additional `full_briefing` JSON property and returns the raw prompt string inside `prompt_used`.

## Database Changes
- None.

## API Changes
- Dashboard API now returns `full_briefing` and `prompt_used` strings within the `morningBrief` object payload.

## Security Changes
- The prompt context is now visible on the frontend. Since the prompt only contains market news context and the ticker symbol (no sensitive environment variables or keys), this is safe.

## Test Results
- Frontend and backend compile successfully without TypeScript errors.

## Known Issues
- None.

## Questions for ChatGPT
- None.
