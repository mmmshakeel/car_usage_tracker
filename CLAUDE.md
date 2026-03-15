# Lease Car KM Logger — Car Usage Tracker

## Project Overview
A Flutter iOS app to log daily odometer readings for a lease car.
The user logs their current odometer reading each day. The app computes km driven
per entry (current - previous reading), tracks against the lease contract limit,
and visualises usage over time.

## Tech Stack
- Flutter (iOS first)
- Riverpod (state management, with riverpod_annotation code generation)
- Drift (SQLite local storage)
- go_router (navigation)
- fl_chart (charts on home screen)
- intl (date formatting)

## Architecture
Feature-first folder structure under lib/:
- lib/features/tracker/       → home screen (chart + summary)
- lib/features/log/           → log kilometer screen (add entry)
- lib/features/settings/      → contract settings screen
- lib/core/database/          → Drift database, tables, DAOs
- lib/core/models/            → shared models
- lib/core/theme/             → colors, text styles, spacing

## Data Model: OdometerEntry
- id (int, auto-increment)
- date (DateTime)
- odometerKm (int)  ← the reading from the dashboard
- note (String, nullable)

## Derived value (not stored): kmDriven
- Computed as: odometerKm − previous entry's odometerKm
- Always computed at read time, never stored

## Data Model: ContractSettings (single row, upserted)
- leaseStartDate (DateTime)
- leaseEndDate (DateTime)
- contractDurationDays (int)  ← auto-computed from dates but editable
- startingOdometerKm (int)    ← odometer at lease start
- maxKmPerContract (int)      ← e.g. 10000

## Computed values (not stored):
- kmDrivenInContract = latestOdometerKm − startingOdometerKm
- remainingKm = maxKmPerContract − kmDrivenInContract
- remainingDays = leaseEndDate − today
- maxKmPerDayIdeal = maxKmPerContract / contractDurationDays
- maxKmPerDayRemaining = remainingKm / remainingDays

## Screens & Navigation

### Bottom navigation bar (persistent)
- Tab 0: Drive Tracker (/) — icon: route/person-with-pin
- Tab 1: Contract Settings (/settings) — icon: car

### Screen 1 — Drive Tracker (Home) "/"
- Title: "Car Usage Track"
- Section: "Kilometer usage"
- Chart (fl_chart): combo chart
  - Bar series: km driven per log entry (derived: current − previous)
  - Line series: cumulative odometer over time (actual readings)
  - X-axis: month labels
- Summary card: current odometer reading + "Last updated [date]"
- CTA row: "Ready to add mileage?" + purple "Log Mileage" button → navigates to /log
- Bottom nav bar

### Screen 2 — Log Kilometer "/log"
- Title: "Log Kilometer"
- Full-month calendar (custom or table_calendar package) for date selection
- Odometer input row:
  - Minus (−) button (circular, black)
  - Number input field showing current km value (suffixed "km")
  - Plus (+) button (circular, black)
  - Increment/decrement by 1
- Purple "Save" button → saves OdometerEntry, pops back to home
- Bottom nav bar

### Screen 3 — Contract Settings "/settings"
- Title: "Contract Settings"
- Fields (all editable):
  - Lease Start Date (date picker, dd-mm-yyyy)
  - Lease End Date (date picker, dd-mm-yyyy)
  - Contract Duration (Days) — stepper, auto-filled from dates
  - Starting Odometer (km) — stepper
  - Maximum KM per Contract — stepper
- Summary card (auto-computed, read-only):
  - Max KM per day (ideal): maxKmPerContract / contractDurationDays
  - Max KM per day (remaining): remainingKm / remainingDays
  - Show both values in the card
- Purple "Save" button → upserts ContractSettings
- Bottom nav bar

## Design System
- Primary accent: purple (#6200EE or similar)
- Background: light grey/white
- Cards: white with subtle rounded corners and shadow
- Buttons: rounded pill shape, purple fill, white text
- Chart line: coral/pink (#FF6B6B)
- Typography: system font (SF Pro on iOS), clean and minimal
- Bottom nav bar: two tabs with icon + label

## Coding Conventions
- Use Riverpod @riverpod code generation (riverpod_annotation)
- Use Drift with typed DAOs, never raw SQL strings
- All UI in widgets/ folder per feature, keep files under 200 lines
- No logic in widget build() methods — use providers
- Use go_router for all navigation with bottom nav shell route
- Always handle loading and error states in UI
- Use const constructors wherever possible
- Prefer named parameters

## Running the App
flutter run -d [iOS simulator or device]

## Code Generation
dart run build_runner build --delete-conflicting-outputs

## Testing
- Unit tests in test/unit/
- Widget tests in test/widget/
- Run: flutter test