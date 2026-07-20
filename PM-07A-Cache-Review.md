# Module
PM-07A AI Stock Intelligence Engine (Cache Update)

## Objective
Add an AI explanation history cache to avoid regenerating the complex Gemini AI response on every load, significantly saving API tokens and improving performance.

## Files Changed
- `backend/prisma/schema.prisma` (Added `cache_metadata`)
- `backend/src/controllers/stockIntelligence.controller.ts` (Implemented material change detection logic)
- `frontend/src/services/stockIntelligence.ts` (Added `force` parameter)
- `frontend/src/components/stocks/StockDetailModal.tsx` (Added Refresh button and metadata footer)

## Architecture Changes
- Implemented a "Material Change" detection layer in the controller. The AI is only invoked if the stock price moves by >2% or if the news hash changes since the last generation, or upon explicit user request.

## Database Changes
- Added `cache_metadata` (Json) to `StockIntelligence` to persistently store `generated_timestamp`, `last_price`, `last_news_hash`, `ai_model_version`, and `analysis_version`.

## API Changes
- `GET /api/stock-intelligence/:symbol` now respects a `?force=true` query parameter to bypass the cache.

## Security Changes
- No new security changes.

## Test Results
- Clean compilation (`npm run build`) on both frontend and backend.
- Caching logic verified.

## Known Issues
- None.

## Questions for ChatGPT
- The PM-07A cache feature is complete. Are we clear to proceed to PM-07B (Gold/Macro AI Intelligence)?
