# Walkthrough: Module PM-01 (Authentication & User Management)

The core authentication logic and UI have been successfully implemented according to the PM-01 specifications. 

## Architectural Foundation

- **Frontend**: Built using React with TypeScript, Vite for lightning-fast bundling, and styled exclusively with Tailwind CSS.
- **Backend**: Robust Node.js API with Express, TypeScript, and Prisma ORM.
- **Database**: PostgreSQL setup included via Docker (`docker-compose.yml`).
- **Security**: Passwords hashed with `bcrypt`, authentication secured via `jsonwebtoken`, and login rate-limiting enabled via `express-rate-limit`.

## Design & Aesthetics

The frontend design features a premium, rich aesthetic that aims to impress:
- **Glassmorphism**: Login and Registration cards utilize backdrop filters (`backdrop-blur`) and semi-transparent backgrounds to create a sleek glass effect.
- **Micro-animations**: Smooth hover transitions, fade-in loading animations, and subtle slow-pulsing background decorations.
- **Color Palette**: A curated dark mode palette focusing on deep slate backgrounds contrasted with vibrant brand accents (Teal/Emerald).
- **Icons**: Professional iconography integrated via `lucide-react`.

## User Flows Implemented

### 1. Registration (`/register`)
- Captures Full Name, Email, Password, and Confirm Password (with real-time validation via `react-hook-form`).
- Optional fields supported: Country, Currency, and Time Zone.
- Passwords matched locally before submitting to the server.

### 2. Login (`/login`)
- Clean, focused interface for returning users.
- Validates credentials against the hashed PostgreSQL entries.
- Emits a JWT token upon success, directing the user seamlessly to their Profile.

### 3. Forgot Password (`/forgot-password`)
- Currently utilizes a **mocked** email service for local development.
- When a valid email is submitted, the backend console logs a simulated email payload containing the reset link and token. 
- The UI handles errors and success states cleanly, prioritizing security by not confirming if an email exists on the system to prevent enumeration attacks.

### 4. User Profile (`/profile`)
- Displays the user's active status and email.
- Allows modifications to Full Name, Country, Currency, and Time Zone.
- Integrates with the backend `PUT /api/user/profile` endpoint, updating the React Auth Context instantly on save.

## Designer Review Request

> [!TIP]
> **For the Design Team**: 
> Please review the glassmorphism effects and color palettes used in the `tailwind.config.js` and `index.css`. The forms have been built using flexible Tailwind utility classes (`input-field`, `btn-primary`, `glass-card`), which makes adjusting padding, border-radii, and hover states incredibly easy if you wish to tune the micro-interactions further.
