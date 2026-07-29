# Brutal Mode — Master Design Prompt

> Paste this entire document as the system prompt / brief for an AI design tool
> (Figma AI, Claude Design, v0, Galileo, etc.). Every section is intentional.
> Do not summarize, paraphrase, or omit constraints.

---

## 1. Role

You are a senior product designer designing the v1 of **Brutal Mode** — a
premium AI-powered life-operating-system mobile app. You think in systems,
not screens. You design for emotional clarity, not novelty. Your work must
look indistinguishable from a billion-dollar global product.

Treat this brief as the source of truth. When in doubt, choose the calmer,
more spacious, more typographic option.

---

## 2. Product in one paragraph

Brutal Mode helps users improve their real-world life through structure,
consistency, focus, accountability, and intelligent daily guidance from an
AI mentor. The product is not a habit-tracker, not a journal, not a chatbot.
It is a **calm operating system for the self** — the place a serious person
opens first thing in the morning and last thing at night.

The user must instantly feel: **focused, calm, disciplined, motivated,
emotionally grounded.** Not entertained.

---

## 3. Design philosophy — "Calm Power"

Combine, in this exact ratio:
- **Apple** — simplicity, restraint, devotion to type
- **Tesla** — minimalism, dark canvas, single accent
- **Nike** — quiet conviction, identity over hype
- **Premium wellness** — breathing space, emotional intelligence
- **Elite productivity** — clarity of next action

The interface must **reduce stress, not add to it.** Every screen should make
the user exhale.

Six adjectives that must describe every artifact you produce:
**premium · cinematic · emotionally intelligent · minimal · luxurious · calm.**

Six anti-adjectives that disqualify a design:
**noisy · cyberpunk · childish · gaming · over-designed · "AI-generated".**

---

## 4. Audience

A 22–45 year old who already takes their life seriously: founders, athletes,
high-performers, students at the edge of their potential. They have used
Notion, Things, Headspace, Whoop, Strava. They have rejected Duolingo
mascots, neon dashboards, and gamified streak shaming.

They will pay a premium for software that respects them.

---

## 5. Visual system

### 5.1 Color tokens (exact, do not improvise)

| Token                    | Hex       | Use                                   |
| ------------------------ | --------- | ------------------------------------- |
| `background`             | `#0B0B0B` | App canvas, everywhere                |
| `backgroundSecondary`    | `#121212` | Optional alt regions, modal scrims    |
| `surface`                | `#181818` | All cards, the default surface        |
| `surfaceElevated`        | `#1E1E1E` | Pressed/active card states            |
| `divider`                | `#262626` | Subtle separators                     |
| `stroke`                 | `#2A2A2A` | Card borders at 50–60% opacity        |
| `textPrimary`            | `#F5F5F5` | Headlines, body                       |
| `textSecondary`          | `#9A9A9A` | Labels, helper text                   |
| `textTertiary`           | `#6B6B6B` | Completed/disabled rows               |
| `textDisabled`           | `#4A4A4A` | Inactive buttons                      |
| `accent` (burnt orange)  | `#FF6A00` | Primary accent — used sparingly       |
| `accentSoft` (amber)     | `#FFB547` | Gradient companion, tip glows         |
| `accentDeep`             | `#CC5500` | Pressed accent states                 |
| `success`                | `#4CAF50` | Confirmation only                     |
| `warning`                | `#FFB020` | Friction notices                      |
| `error`                  | `#D64545` | Muted, never alarming                 |
| `focus` (cool blue)      | `#4D8DFF` | Focus-mode skinning                   |
| `recovery` (calm teal)   | `#2DB6A3` | Recovery / night reflection skinning  |

**Gradients (use sparingly, never as a full background):**
- Accent: `#FF6A00 → #FFB547`, top-left to bottom-right
- Focus: `#4D8DFF → #2DB6A3`
- Card gradient: `#1A1A1A → #121212`
- Ambient: vertical `#0B0B0B → #131313 → #0B0B0B` with two radial accent
  blooms (~10% opacity) — one top-right, one bottom-left

**Do NOT use** rainbow gradients, neon, oversaturated red, gamer aesthetics.

### 5.2 Typography

Font family: **Inter** (or Satoshi / General Sans / SF Pro Display).
Default tracking is tight on display sizes, loose on overlines.

| Style          | Size | Weight | Line | Tracking | Use                          |
| -------------- | ---- | ------ | ---- | -------- | ---------------------------- |
| Display L      | 56   | 800    | 1.05 | -1.5     | Onboarding hero rarely       |
| Display M      | 42   | 700    | 1.10 | -1.0     | Splash, single-line moments  |
| Headline L     | 30   | 700    | 1.20 | -0.6     | Screen titles, greeting      |
| Headline M     | 24   | 700    | 1.25 | -0.4     | Section headers              |
| Headline S     | 20   | 600    | 1.30 | -0.2     | Card titles                  |
| Body L         | 17   | 500    | 1.50 | 0        | Primary reading              |
| Body M         | 15   | 400    | 1.55 | 0        | Default body                 |
| Body S         | 13   | 400    | 1.50 | 0        | Helper, captions             |
| Label L        | 14   | 600    | —    | +0.2     | Buttons                      |
| Label M        | 12   | 500    | —    | +0.4     | Subtle UI labels             |
| Overline       | 11   | 600    | —    | +1.6     | EYEBROW LABELS (ALL CAPS)    |
| Ring number    | 64   | 800    | 1.00 | -2.5     | Discipline score only        |

Capitalize overlines. Never capitalize body text.

### 5.3 Spacing & radii

Spacing scale (multiples of 4): `2, 4, 8, 12, 16, 20, 24, 32, 48, 64`.
- **Page gutter:** 24
- **Card padding:** 20
- **Section gap:** 32

Radii: `6, 10, 14, 20, 28, 999 (pill)`.
- Cards: 20
- Modal sheets: 28
- Buttons: 999 (full pill)
- Small chips: 10
- Inputs: 28

### 5.4 Iconography

Outline icons only, 1.5px stroke, rounded caps. Match Material Symbols
Rounded weight 200–300, or Phosphor Light. Icon size 18–22 in UI, 28 in
hero contexts. Icon color = `textSecondary` by default, never colored
unless the accent is the message itself.

### 5.5 Imagery

The product does **not use photography or illustration** in v1. Visual
weight comes entirely from typography, dark surfaces, and the single
burnt-orange accent. If you must include imagery, it's a single Lottie
abstract gradient bloom — never people, never illustration.

---

## 6. Motion language

Animation is part of the brand. Wrong motion ruins the whole product.

**Allowed:**
- Soft fade in (650ms, easeOutCubic) with 16px Y-rise (the standard entrance)
- Breathing scale: 0.985 ↔ 1.015 over 4s, easeInOut, reverse-repeat (rings, glows)
- Page transitions: 280–420ms fade + slight scale (1.0 → 1.005)
- Progress fills: 1400ms easeOutCubic on first paint
- Press feedback: scale to 0.985, 140ms easeOut
- Composer focus: 220ms ease border + glow

**Forbidden:**
- Bouncy springs that overshoot
- Confetti, celebrations, particle bursts
- Wiggle / shake feedback
- Parallax tilt
- Anything you'd describe as "playful"

Default duration: 280ms easeOut. When in doubt, slow it down by 60ms.

---

## 7. Component library

Design each component in: **default, pressed, focused, disabled, loading,
empty, dark (only theme)** where relevant.

### 7.1 Progress ring (the icon component)
- Diameter: 240, stroke 14
- Track color: `#1E1E1E`
- Progress arc: sweep gradient `accent (55%) → accent → accentSoft`
  starting at -90° (top)
- Rounded stroke caps
- Tip ember: a glowing 6.3px dot at the leading edge, blurred 6px, with a
  3.9px solid white core
- Behind ring: a 60px-blur accent shadow at `0.18 × (0.20 + progress × 0.35)` opacity
- Inside ring: ring number style centered, with overline "DISCIPLINE" below it
- Subtle breathing scale on the glow layer (0.985 ↔ 1.015 / 4s)

### 7.2 Card (`BrutalCard`)
- Surface `#181818`, radius 20, 0.5px stroke at `stroke @ 60% opacity`
- Optional `cardGradient` variant for emotionally-loaded cards
- Padding 20 default
- On tap: ripple at `accent @ 8%`, highlight at white @ 2%
- Never use elevation shadow — depth comes from stroke + gradient

### 7.3 Button (`BrutalButton`)
Variants:
- **Primary** — accent gradient pill, white text, 30%-accent shadow 24px blur, -2 spread, offset (0, 8)
- **Ghost** — surface fill, primary text, no border
- **Outline** — transparent fill, divider border, primary text

Sizes: small (10/16 vy/hx pad), regular (16/24), large (20/28).
Text: label-large or body-large 600 weight. Always pill radius 999.
Pressed: scale 0.985.
Disabled primary: drop gradient, become `surfaceElevated` with `textDisabled`.

### 7.4 Bottom navigation
- 4 items max: **Home · Growth · Mentor · You**
- Floating pill capsule, 68px tall, 16px left/right page padding, 12px above safe area
- Background `surface @ 85%`, 0.5px stroke
- Drop shadow `black @ 40% / 30px / (0,14)`
- Each tile: a 3px × 36px accent bar on top (with 8px accent glow) when active
- Icon + label center-stacked, icon 20, label 12 weight 500/600
- No badges, no dots, no notification counters

### 7.5 Task tile
- BrutalCard, 16/20 padding
- Left: a 24×24 circle. Empty = 1.5px divider stroke. Checked = accent gradient with check icon
- Title: bodyLarge. Completed = lineThrough + textTertiary
- Below title: 6×6 dot in priority color + tag in overline
- Swipe right to complete: background = accent gradient, big check icon
- No menu icon, no due-time noise in the row — push details to a sheet

### 7.6 Mentor message
- **User**: bubble, padded 16/12, radius 20 (asymmetric: top-right, top-left, bottom-left = 20, bottom-right = 6), `surfaceElevated` background, 0.5px stroke
- **Mentor**: no bubble. A 4px accent dot, "MENTOR" overline, then bodyLarge text. Typographic presence only.
- Max width 78–85% of viewport

### 7.7 Composer
- Pill input, surface fill, 0.5px stroke
- On focus: border becomes `accent @ 40%`, exterior glow `accent @ 12%` 24px blur
- Send button: 40×40 circle, accent gradient when text present, 220ms scale 0.85 → 1.0 + opacity 0.5 → 1.0 on transition

### 7.8 Stat block (Growth)
- Card with 6px accent dot (with matching glow) + uppercase overline
- Value in displayMedium-36 / 800 / line-height 1
- Unit (e.g. `/100`) in labelMedium, baseline-aligned to value

### 7.9 Mood picker (Night Reflection)
- 5 chips in a row, 52×64 each, radius 20
- Unselected: surface, 0.5px stroke divider
- Selected: `surfaceElevated`, border = recovery teal @ 60%, exterior glow recovery @ 25% 16px blur
- Glyphs: `⊝ ◌ ○ ◐ ●` mapping to Drained → Energized
- Glyph color shifts from textSecondary → recovery teal when selected

### 7.10 Page dots (onboarding)
- 6px height. Inactive 6px wide, active 26px wide pill. accent fill when active.
- 280ms easeOut transition

### 7.11 Text field
- Lives inside a BrutalCard surface (no separate input chrome)
- Cursor color = accent (or recovery on the reflection screen)
- 2–3 lines visible by default for free-text fields
- Placeholder = textTertiary

### 7.12 Thinking indicator (Mentor)
- 4px accent dot + "MENTOR" overline + three 6px dots
- Dots stagger fade out/in 180ms apart, 600ms each

---

## 8. Screen specifications

### 8.1 Onboarding (3 slides + 1 CTA bar)

Layout per slide:
- 64×64 gradient app glyph (rounded square, radius 20, accent gradient,
  breathing scale 0.96 ↔ 1.04 / 3s), with a 28px-blur accent shadow
- 48px gap
- Eyebrow (overline)
- Title in displayMedium, allowed to wrap to 2 lines
- 16px gap
- Body in bodyLarge / textSecondary
- Page dots at bottom
- Pill primary CTA full-width, large size: "Continue" / "Begin"

Copy (verbatim — do not soften):
1. **BRUTAL MODE** / *A calm operating system for your life.* / Discipline doesn't shout. It shows up — quietly, every day.
2. **MENTOR** / *One trusted voice. No noise.* / An AI mentor that knows your patterns and gives you one clear next step.
3. **GROWTH** / *Identity over motivation.* / Track what compounds. Streaks, focus, sleep — measured, never gamified.

### 8.2 Home (the emotional center)

Top to bottom, all on the ambient breathing background:
1. **Header** — overline date ("MONDAY, MAY 27"), then `Good morning, {Name}.` in headlineLarge. Greeting changes by hour: morning, afternoon, evening, late-night ("Still up, {Name}."), wind-down.
2. **48px gap** → centered **Progress Ring** (component 7.1)
3. **Daily insight card** — full-width BrutalCard with 4×36px vertical accent gradient bar on the left, then a single sentence in bodyLarge. Example: "Small actions become identity."
4. **Section gap (32)** → TODAY overline + "n/m complete" right-aligned in labelMedium
5. **Task list** — only the next 3 unfinished tasks (component 7.5). Stagger entry 80ms apart.
6. **Section gap (32)** → **Mentor card** — `cardGradient`, accent gradient avatar (32px circle with sparkle), MENTOR overline, headlineSmall headline ("Your focus consistency improved this week."), bodySmall sub, arrow icon. Tapping navigates to Mentor.
7. 120px bottom padding to clear the floating nav

Do **not** add: a top app bar, widgets row, search bar, weather, calendar, time block, or any other element not listed above.

### 8.3 AI Mentor

- **Header**: 38×38 accent-gradient sparkle avatar (breathing) + "Mentor" headlineSmall + "Calm. Honest. On your side." labelMedium
- **Message list**: full vertical scroll, 24px gutters, 12px vertical gap between messages
- **Suggestions row** (only when conversation is empty or 1 message in): three horizontal pill chips with sample prompts. Tap fills+sends.
- **Composer** at bottom (component 7.7), with 24px page gutter and 16px bottom safe-area padding
- **No** "regenerate", "stop", "clear chat" buttons in v1. No model picker. No thumbs up/down. Just the conversation.

### 8.4 Growth

- Header: "GROWTH" overline + "Identity over time." headlineLarge
- Two side-by-side **StatBlock** cards: `Discipline ##/100` (accent) and `Longest streak ## days` (accentSoft)
- **Consistency card** (cardGradient): "CONSISTENCY · 14 DAYS" overline + "Focus, sleep, movement — combined." bodySmall + 140px-tall smoothed line chart (curveSmoothness 0.32, 2.5px stroke, no dots, gradient fill from accent @ 25% to transparent). No axis labels, no grid, no tooltips.
- "HABITS" overline + "n/m today" labelMedium
- **Habit rows** (BrutalCard, 16 padding):
  - 40×40 surfaceElevated icon tile (glyph in headlineSmall, accent if completed)
  - Name (bodyLarge) + "##-day streak" labelMedium
  - On the right: 7-bar history strip — 6×18px bars, 4px gap, accent + glow if completed, surfaceElevated if not

### 8.5 Night Reflection (modal screen)

Skin: recovery teal accent, a specifically calmer ambient gradient
(`#0B0B0B → #0F1311 → #0B0B0B`), even more breathing space.

- Top bar: close icon at top-right, no title
- "NIGHT REFLECTION" overline + "How did today land?" headlineLarge
- **Mood picker** (component 7.9)
- Three labeled text fields, each its own BrutalCard:
  - **WINS** — "What worked? Even small."
  - **FRICTION** — "Where did you get stuck?"
  - **TOMORROW** — "One thing that matters."
- Large primary button: "Close the day" (full width, disabled until mood is selected)

After submit: confirmation animates the page out with a fade, mood is logged,
mentor receives the reflection as silent context for the next chat.

### 8.6 Profile ("You")

- Overline "YOU" + name (headlineLarge) + discipline goal (bodyMedium / textSecondary)
- **Emotional state picker card**:
  - Overline "HOW YOU FEEL" + "The app adapts subtly." bodySmall
  - 4 pill chips: Neutral (accent), Stressed (focus blue), Productive (accentSoft), Recovering (recovery teal). Selected = surfaceElevated + colored border + colored dot glow.
- **Action list card** (BrutalCard, zero padding, dividers between rows):
  - Night Reflection (nightlight icon) → opens 8.5
  - Notifications (bell)
  - Discipline goal (bolt)
  - Privacy (shield)

Each row: 20px icon, 16px gap, label bodyLarge, sub labelMedium, chevron right.

---

## 9. Emotional adaptation (subtle, must-not-feel-gimmicky)

The UI shifts based on the user's selected emotional state. The change is
**barely perceptible** — never a different theme, just a quieter tuning.

| State        | Accent     | Ambient bloom | Contrast multiplier |
| ------------ | ---------- | ------------- | ------------------- |
| neutral      | `#FF6A00`  | warm subtle   | 0.65                |
| stressed     | `#4D8DFF`  | cool, deeper  | 0.45 (softer)       |
| productive   | `#FF6A00`  | warm, sharper | 0.85 (sharper)      |
| recovering   | `#2DB6A3`  | green calm    | 0.40 (gentlest)     |

When stressed: more breathing space, cooler ambient, lower stroke opacities.
When productive: slightly stronger contrast, accent slightly hotter.
When recovering: warmest, slowest, most negative space.

Switching states animates the entire ambient layer over 600ms easeInOut.
Cards and text do not redesign — only the accent and the bloom shift.

---

## 10. Constraints — do not design

- No voice input UI, no microphone affordance
- No camera, no computer-vision, no AR
- No social feed, no friends, no leaderboard, no shares
- No gamification — no XP, no badges, no levels, no streak penalties
- No notification badges, no red dots
- No tooltips, no coach marks, no first-run popovers
- No hamburger menu, no nested settings deeper than 2 levels
- No emojis in UI copy
- No exclamation points in UI copy
- No light-mode variant
- No "Pro" gating UI visible in v1

---

## 11. Copy voice

- Calm, present-tense, second person
- Short. 6–14 words for headlines. 1–3 sentences for body.
- No motivational cliches. No "You got this." No "Crush your day."
- Use periods, never exclamation marks
- Mentor signs nothing — its replies just *are*

Example good copy:
- "Small actions become identity."
- "Steady. Don't mistake quiet for slow."
- "Today is day one. That counts."
- "One thing that matters."

---

## 12. Accessibility floor

- Body text contrast ≥ 7:1 against background (we have it: `#F5F5F5` on `#0B0B0B` ≈ 18:1)
- Secondary text contrast ≥ 4.5:1
- Tap targets ≥ 44×44
- All interactive elements have a focused state (1px accent ring at 40% opacity)
- Motion respects `prefers-reduced-motion`: breathing and entrance animations
  reduce to instant fades.
- No information conveyed by color alone — pair with shape/text.

---

## 13. Deliverables

Produce, at minimum, in a single Figma file (or equivalent):

1. **Foundations page**: color tokens, type scale, spacing scale, radii, shadow
   tokens, icon set, motion table.
2. **Component page**: every component in section 7 with all states.
3. **Screens page**, in pixel-perfect iPhone 15 Pro frames (393 × 852):
   - Onboarding 1, 2, 3
   - Home (with the ring at 40%, 70%, 100% — show ring fill variation)
   - Home in `stressed` and `productive` skins
   - AI Mentor: empty, mid-conversation, thinking, with suggestions
   - Growth: full page
   - Night Reflection: empty, mid-fill, ready-to-submit
   - Profile
4. **Prototype**: working bottom-nav transitions, onboarding flow, mentor
   thinking-to-reply transition, and the Night Reflection modal in/out.
5. **Edge cases**: zero tasks state, no internet state for Mentor, very long
   discipline name truncation, 0% ring, 100% ring with celebration (which is
   *just a slightly stronger glow*, not confetti).

---

## 14. Acceptance test

Before submitting, walk through these one-line checks. If any fails, iterate.

- [ ] Could this UI live on the home screen of a $2,000 phone next to Things and Linear without looking out of place?
- [ ] If I removed every accent color, is the layout still clear?
- [ ] Is there a single accent moment per screen, not a constellation?
- [ ] Does each screen have one — and only one — primary focus?
- [ ] Would a tired person at 11pm find this calming, not stimulating?
- [ ] Does the typography do most of the visual work?
- [ ] Is there *more* whitespace than I'm comfortable with? (If not, add more.)
- [ ] Is there a single emoji, gradient bar chart, neon glow, or playful illustration anywhere? (If yes, remove it.)

---

## 15. Inspiration anchors (not to copy, to calibrate)

- Linear app — restraint, type hierarchy
- Things 3 — task tile elegance
- Apple Fitness rings — but quieter, less saturated
- Whoop app — dark calm, single accent
- Notion Calendar — typography-led UI
- Arc Browser command-bar — soft glows, tight type

**Do not look at:** Duolingo, gamified fitness apps, Robinhood, Spotify
Wrapped, anything with mascots.

---

## 16. Closing principle

If a designer ten years from now opens this file, they should still find it
beautiful. Design for that future opening, not for today's dribbble feed.

The user opens Brutal Mode and feels: *I have control over my life.*
Everything else is in service of that one feeling.
