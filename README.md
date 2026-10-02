# BISSOSTO.COM — Production Full-Stack Starter

This is the deployable full-stack version of Bissosto.com. It is not a localStorage-only demo.

## Stack
- Node.js + Express
- PostgreSQL
- Secure bcrypt password hashing
- HTTP-only JWT cookie sessions
- Rate limiting + Helmet
- Responsive customer storefront
- Customer registration/login
- Persistent addresses
- Persistent orders and order address snapshots
- Product + stock management
- Admin dashboard
- Bangla/English language preference
- Dark mode
- COD order flow
- Payment-gateway integration points for bKash/Nagad/Card

## Run locally
1. Install Node.js 20+.
2. Create a PostgreSQL database.
3. Copy `.env.example` to `.env` and fill in `DATABASE_URL`, `JWT_SECRET`, `ADMIN_EMAIL`, and `ADMIN_PASSWORD`.
4. Run `npm install`.
5. Run `npm start`.
6. Open `http://localhost:3000`.
7. Admin: `http://localhost:3000/admin.html`.

The server creates the database tables automatically on startup.

## Production
Use a managed PostgreSQL database and a Node-capable host. Configure all environment variables in the host dashboard. Do not commit `.env` or payment secrets to Git.

The public storefront can be opened without login. Customers must log in to save addresses and place orders. Admin access is role-protected on the server.

## Payments
COD is the only fully executable payment method in this starter. bKash/Nagad/Card are represented as payment methods and intentionally return `pending_gateway` until the merchant's approved gateway credentials and callback/webhook flow are configured. Never fake a successful payment.

## Before going live
- Connect a real domain such as `bissosto.com`.
- Use a managed PostgreSQL database with backups.
- Set a strong random `JWT_SECRET`.
- Set a strong admin password.
- Configure HTTPS at the hosting layer.
- Add your approved payment gateway credentials as environment variables.
- Implement and test gateway success/cancel/fail callbacks and server-side verification before accepting online payments.
- Add your real product catalogue, prices, stock, delivery policy, refund policy and contact information.
