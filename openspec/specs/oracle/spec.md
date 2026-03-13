# Capability: Oracle (Predictive Engine)

The Oracle is the intelligence engine that analyzes past user behavior to project future outcomes. It transforms completion timestamps into real-world time estimates.

## 1. Pace Definition

Pace is the core metric. To ensure the Oracle is sensitive to recent habit changes, we use a **Rolling Window**.

### Daily Pace Calculation (`daily_pace`)
1.  **Active Window (7 days):** The system looks at the last 7 days.
2.  **Formula:** `completed_subtasks_in_window / 7`.
3.  **Fallback (Early Goal):** If the goal started less than 7 days ago, use the average since `start_date`.

---

## 2. Completion Projection (ETA)

The projection calculates the estimated completion date of the Meta Global (`Goal`).

### Variables
- `remaining_subtasks`: Total subtasks in Goal - Completed subtasks.
- `current_pace`: The `daily_pace` calculated above.

### ETA Formula
- `days_to_finish = remaining_subtasks / current_pace`
- `estimated_completion_date = Today + days_to_finish`

*Exception:* If `current_pace == 0`, the `estimated_completion_date` is infinity (signal "Stalled Goal").

---

## 3. Oracle States (Visual Feedback)

The Oracle categorizes goal health by comparing `estimated_completion_date` with the Goal's `target_date`:

| State | Condition | Visual Meaning |
| :--- | :--- | :--- |
| **On Track** | `estimated_completion_date` <= `target_date` | Green. Current pace is sufficient. |
| **At Risk** | `estimated_completion_date` > `target_date` (up to 20% delay) | Yellow. Suggest minor effort increase. |
| **Behind** | `estimated_completion_date` > `target_date` (> 20% delay) | Red. Urgent need for replanning. |
| **Stalled** | No subtasks completed in the last 14 days | Gray. "Where did we stop?". |

---

## 4. Volume Oracle (Alternative Projection)

Inspired by the PRD: *"At this reading pace, you will read 36 books in a year instead of 12"*.

### Annual Volume Calculation
- `estimated_annual_volume = daily_pace * 365`.
- Useful for habit or accumulation goals (e.g., pages read, kms run).

---

## 5. Technical Data Requirements

To ensure the Oracle performs efficiently:
- **Indexing:** The `completed_at` field in `Subtasks` must be indexed.
- **Caching:** Oracle calculations can be heavy. They should be recalculated only when a subtask is completed or once per day (via background job).
