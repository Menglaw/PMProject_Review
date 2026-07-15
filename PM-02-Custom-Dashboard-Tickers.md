# Module
PM-02 Custom Dashboard Tickers

## Objective
The dashboard's middle row, which previously displayed five hardcoded market indices, needed to be overhauled to support full customization so that the user can build their own personalized market watchlist right on the dashboard.

## Files Changed
- `backend/prisma/schema.prisma`
- `backend/src/services/marketData.service.ts`
- `backend/src/controllers/dashboard.controller.ts`
- `backend/src/routes/dashboard.routes.ts`
- `frontend/src/pages/dashboard/MainDashboard.tsx`
- `frontend/src/hooks/useDashboardData.ts`
- `frontend/src/components/dashboard/TickerSettingsModal.tsx` (NEW)

## Architecture Changes
- Created a dynamic `TickerCache` service inside `marketData.service.ts`. It intercepts any tickers requested by users, checks if we've fetched them within the last 2 minutes across the entire app, and batches new requests to Yahoo Finance to guarantee near real-time pricing without hitting API rate limits.
- The frontend dynamically maps `marketAssets` and provides a TickerSettingsModal to control the `dashboard_tickers` array.

## Database Changes
- Appended `dashboard_tickers String[] @default(["^GSPC", "BTC-USD", "GC=F", "^VIX", "^TNX"])` to the `User` schema.
- Synchronized schema with PostgreSQL using `prisma db push`.

## API Changes
- New Endpoint: `PUT /api/dashboard/tickers`
  - Payload: `{ tickers: string[] }`
  - Purpose: Updates the logged-in user's `dashboard_tickers` in the database.

## Security Changes
- The new endpoint is protected by the `authenticateToken` JWT middleware.
- Validates the array length (max 10) to prevent abuse.

## Test Results
- Backend TypeScript compiles cleanly.
- `prisma db push` succeeded.
- Verified backend runs properly with the new dynamic fetching loop.

## Known Issues
- Currently, the AI morning brief generation inside the dashboard data fetcher assumes a global market snapshot. As users fetch diverse sets of individual stocks, the AI insights might become fragmented or highly personalized based on whichever user triggers the 2-minute cache refresh first. This may need to be decoupled in the future.

## Questions for ChatGPT
None.
