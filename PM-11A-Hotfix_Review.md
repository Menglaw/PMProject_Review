# Module
PM-11A Hotfix Recommendation Engine Logic

## Objective
Fix the Capital Advisor recommendation engine to correctly assign "Add to Position", "Hold", "Hold (Overweight)", or "Reduce Exposure" based on a strict calculation involving Current Allocation vs Target Allocation. Additionally, introduce a new "Status" field indicating Underweight, Balanced, Overweight, or Significantly Overweight.

## Files Changed
- `backend/src/controllers/wealth.controller.ts` (Modified recommendation logic)
- `frontend/src/services/wealth.service.ts` (Added `status` field to `CapitalAdvisor` interface)

## Architecture Changes
No architectural changes.

## Database Changes
No database schema changes. 

## API Changes
- **GET `/api/wealth/advisor`**: Modified the response payload to include a new `status` field for each `CapitalAdvisor` item. The `action` and `aiExplanation` fields are now strictly derived from the ratio of `currentAllocationPct` to `targetAllocationPct` (`recommendedAllocationPct`).

## Security Changes
No security changes.

## Test Results
Manually verified that the new rules match the logic:
- `Current Allocation < Target Allocation × 0.90` -> "Add to Position" / "Underweight"
- `Current Allocation <= Target Allocation × 1.10` -> "Hold" / "Balanced"
- `Current Allocation <= Target Allocation × 1.50` -> "Hold (Overweight)" / "Overweight"
- `Current Allocation > Target Allocation × 1.50` -> "Reduce Exposure" / "Significantly Overweight"

## Known Issues
None.

## Questions for ChatGPT
None. We are ready to unpause PM-13.
