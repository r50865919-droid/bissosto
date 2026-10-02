CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'customer'
        CHECK (role IN ('customer', 'admin')),
    language TEXT NOT NULL DEFAULT 'bn',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS addresses (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL
        REFERENCES users(id) ON DELETE CASCADE,
    label TEXT DEFAULT 'Home',
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL,
    district TEXT NOT NULL,
    area TEXT NOT NULL,
    address_line TEXT NOT NULL,
    note TEXT,
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS products (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    name_bn TEXT,
    description TEXT,
    price NUMERIC(12,2) NOT NULL CHECK (price >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    image_url TEXT,
    category TEXT,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL
        REFERENCES users(id),

    status TEXT NOT NULL DEFAULT 'pending',

    payment_method TEXT NOT NULL,
    payment_status TEXT NOT NULL DEFAULT 'unpaid',

    total NUMERIC(12,2) NOT NULL,

    -- Delivery address snapshot
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL,
    district TEXT NOT NULL,
    area TEXT NOT NULL,
    address_line TEXT NOT NULL,
    note TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS order_items (
    id BIGSERIAL PRIMARY KEY,

    order_id BIGINT NOT NULL
        REFERENCES orders(id) ON DELETE CASCADE,

    product_id BIGINT NOT NULL
        REFERENCES products(id),

    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_orders_user
    ON orders(user_id);

CREATE INDEX IF NOT EXISTS idx_orders_created
    ON orders(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_addresses_user
    ON addresses(user_id);

CREATE INDEX IF NOT EXISTS idx_products_category
    ON products(category);

CREATE INDEX IF NOT EXISTS idx_order_items_order
    ON order_items(order_id);
