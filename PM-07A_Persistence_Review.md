# Module
PM-07A / Persistence Fix – AI Intelligence & Database Stability

## Objective
The objective was to fix a critical database reset issue occurring upon server startup via `start.bat` (which wiped out the user's custom portfolio assets and Gemini API key setting), and to significantly enhance the Stock Intelligence module to base its analysis on injected, mathematically-calculated technical indicators rather than raw pricing data alone.

## Files Changed
- `start.bat`: Removed the `--accept-data-loss` flag from Prisma push to preserve user schemas safely; added logic to execute `seed.ts` only when needed.
- `backend/prisma/seed.ts`: Replaced destructive `deleteMany` commands with safe, idempotent `.count()` conditional statements. It now only seeds simulated portfolios and AI models if the database tables are completely empty, preventing user data wipes.
- `backend/src/controllers/stockIntelligence.controller.ts`: 
  - Integrated `yahooFinance.historical()` to fetch one year of stock prices.
  - Implemented real-time processing of SMA (20, 50, 200), RSI (14), and MACD using the `technicalindicators` package.
  - Injected these technical indicators strictly into the AI generation prompt for PM-07A to enhance analysis accuracy and minimize hallucination.
  - Refined error handling and AI fallback reporting to explicitly state when an invalid/missing API key is causing the system to reject the AI response.

## Architecture Changes
- The AI Engine now synthesizes structured prompt data against factual historical calculations rather than relying solely on abstract real-time quotes.

## Database Changes
- No schema alterations. Operations modified to employ idempotent seeding to maintain long-term persistence across restarts.

## API Changes
- No structural changes to endpoints, but the returned `data` object for `/api/stock-intelligence/:symbol` now exhibits substantially improved fidelity and explicit error communication if the API key fails.

## Security Changes
- Explicit error reporting reduces "black-box" failure modes without exposing backend stack traces.

## Test Results
- **Startup Script Testing**: Confirmed `start.bat` bypasses wiping functionality. "Default admin user already exists" is logged, and existing DB state persists across restarts.
- **AI Logic Extraction**: Successfully calculated RSI, MACD, and SMAs on backend and packaged them into the AI prompt pipeline.

## Known Issues
- Currently requires the user to input a valid Gemini API Key to access live AI generation. Dummy keys return clear fallback data.
- 404 Model errors for Google Gemini are explicitly caught and passed to the frontend via fallback generation logic, but frontend might still display empty tables without explicit styling to handle the error message gracefully.

## Questions for ChatGPT
None. Proceed to next modules as requested by the user.
