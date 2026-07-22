# Module
PM-10A – AI Personal Wealth Manager

## Objective
Transform Project Millionaire from an investment analysis platform into a personal wealth management assistant. This module builds the foundation for personalized guidance by aggregating existing portfolio data with AI insights.

## Files Changed
- `backend/prisma/schema.prisma` [MODIFIED]
- `backend/src/controllers/wealth.controller.ts` [NEW]
- `backend/src/routes/wealth.routes.ts` [NEW]
- `backend/src/index.ts` [MODIFIED]
- `frontend/src/services/wealth.service.ts` [NEW]
- `frontend/src/pages/dashboard/wealth/WealthDashboard.tsx` [NEW]
- `frontend/src/pages/dashboard/wealth/CapitalAdvisorPage.tsx` [NEW]
- `frontend/src/pages/dashboard/wealth/IncomePlannerPage.tsx` [NEW]
- `frontend/src/App.tsx` [MODIFIED]
- `frontend/src/components/layout/Sidebar.tsx` [MODIFIED]

## Architecture Changes
- **Backend:** A new `WealthController` was created to act as an aggregator. It pulls data from `Portfolio` and `StockIntelligence` to compute comprehensive portfolio views (overview, summaries, advisory action, risk) dynamically, without duplicating standard logic.
- **Frontend:** A new "Wealth Manager" suite was introduced with dedicated pages for Wealth Overview (including Morning Brief, Risk, Goals), Capital Advisor, and Income Planner.

## Database Changes
- Added the `UserGoal` model to `schema.prisma` to allow tracking of personalized targets (Income, Portfolio Value, Retirement). This is linked to the `User` model via a one-to-many relationship.

## API Changes
- `GET /api/wealth/overview` - Returns aggregated metrics for the user's portfolio.
- `GET /api/wealth/summary` - Returns a daily AI personal summary.
- `GET /api/wealth/advisor` - Returns capital allocation recommendations by comparing portfolio positions against recent AI recommendations.
- `GET /api/wealth/income` - Estimates dividend and optional income using Yahoo Finance live data.
- `GET /api/wealth/risk` - Computes portfolio risk metrics.
- `GET /api/wealth/goals` & `POST /api/wealth/goals` - Manages `UserGoal` creation and fetching.

## Security Changes
- All endpoints are secured with the standard `protect` middleware to ensure data is strictly scoped to the authenticated user's portfolio.

## Test Results
- Database schema generated successfully.
- Code compiles, and all routing wires up successfully without structural issues. 

## Known Issues
- Currently, options income estimates are placeholders, as the system does not yet track active option premium generation or assign it to positions. This will need deeper integration with `OptionsIntelligence`.
- The Capital Allocation Advisor correctly isolates stocks as requested by the user, skipping Crypto and Gold.

## Questions for ChatGPT
- Now that the Morning Brief and Wealth Dashboard exist, should PM-10B focus on linking actual transaction history to the portfolio to get absolute performance attribution, or expand the AI summary capabilities with an LLM prompt that writes custom daily paragraphs?
