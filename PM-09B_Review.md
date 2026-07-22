# Module
PM-09B – AI Accuracy Tracker & Self-Improvement Engine

## Objective
Build an AI Accuracy Tracker that measures how accurate previous AI recommendations were over time, making the AI accountable and continuously measurable, without duplicating data storage.

## Files Changed
- `backend/prisma/schema.prisma` [MODIFIED]
- `backend/src/app.ts` (Actually `backend/src/index.ts`) [MODIFIED]
- `backend/src/controllers/stockIntelligence.controller.ts` [MODIFIED]
- `backend/src/routes/aiAccuracy.routes.ts` [NEW]
- `backend/src/controllers/aiAccuracy.controller.ts` [NEW]
- `frontend/src/App.tsx` [MODIFIED]
- `frontend/src/components/layout/Sidebar.tsx` [MODIFIED]
- `frontend/src/services/accuracy.service.ts` [NEW]
- `frontend/src/pages/AIAccuracyTracker.tsx` [NEW]

## Architecture Changes
- Backend calculates accuracy dynamically using the existing `AIDecisionTimeline` supplemented with the `entry_price` and current cached prices from `StockIntelligence`, avoiding duplicate tables.
- Frontend includes a new React page using `recharts` for visual representations of accuracy, portfolio attribution, best/worst predictions, and recommendation performance.

## Database Changes
- Added `entry_price` (Float?) to `AIDecisionTimeline` to track the exact price at the moment a recommendation was generated. This allows dynamic calculation of return percentages over time.

## API Changes
- `GET /api/accuracy/timeline`: Returns recent events from `AIDecisionTimeline` enriched with `return_pct` and `classification` (Correct/Neutral/Incorrect).
- `GET /api/accuracy/dashboard`: Returns aggregated metrics like `winRate`, `avgReturnByRecommendation`, and top 5 best/worst performers.
- `GET /api/accuracy/scorecard`: Maps active stocks to their current overall score, risk level, and latest recommendation.
- `GET /api/accuracy/attribution`: Provides portfolio attribution data breaking down returns into AI Added Value, Market Movement, Stock Selection, and Timing (using simplified proxy logic).

## Security Changes
- All new routes are protected using the existing `protect` middleware from `auth.middleware.ts`, requiring a valid JWT.

## Test Results
- Compilation and schema generation successful. 
- Controllers properly fallback when external data isn't immediately available, ensuring resilience.
- Tested edge cases around missing `entry_price` for legacy records (ignored in dashboard stats to preserve accuracy).

## Known Issues
- Currently, attribution data uses a simplified static simulation because full user portfolio history and transaction mapping are beyond the scope of just tracking AI recommendations. Future iterations could tie `AIDecisionTimeline` directly to `Portfolio` purchases for true dollar-weighted attribution.
- Database wasn't running in local docker setup, so manual testing of UI with live data was substituted with structural/code verifications.

## Questions for ChatGPT
- Should we expand the Portfolio Attribution engine in PM-10 to use actual user transaction data (comparing real user entry prices to AI entry prices) instead of theoretical returns?
- Are there any specific threshold rules you want to adjust for the Correct/Neutral/Incorrect classification (currently set to +/- 2% for buys/sells and +/- 5% for holds)?
