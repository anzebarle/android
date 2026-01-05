DROP SCHEMA IF EXISTS ep;
CREATE SCHEMA ep;
USE ep;
CREATE TABLE users (
    id_users INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'SELLER', 'CUSTOMER') NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    id_addr INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    street VARCHAR(100),
    house_number VARCHAR(10),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id_users)
);

CREATE TABLE products (
    id_prod INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_path VARCHAR(255),
    in_stock BOOLEAN DEFAULT TRUE
);

CREATE TABLE cart (
    id_cart INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(id_users)
);

CREATE TABLE cart_items (
    id_cart_items INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (cart_id) REFERENCES cart(id_cart),
    FOREIGN KEY (product_id) REFERENCES products(id_prod),
    UNIQUE (cart_id, product_id)
);


CREATE TABLE orders (
    id_ord INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    status ENUM('NEW', 'CONFIRMED', 'CANCELLED', 'STORNO') NOT NULL DEFAULT 'NEW',
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id_users)
);

CREATE TABLE order_items (
    id_order_items INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id_ord),
    FOREIGN KEY (product_id) REFERENCES products(id_prod),
    UNIQUE (order_id, product_id)
);

CREATE TABLE ratings (
    id_ratings INT AUTO_INCREMENT PRIMARY KEY,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id_users),
    FOREIGN KEY (product_id) REFERENCES products(id_prod),
    UNIQUE (user_id, product_id)
);

CREATE TABLE certificates (
    id_cert INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(255) NOT NULL,
    issuer VARCHAR(255) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    valid_from DATE,
    valid_to DATE,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id_users)
);

INSERT INTO products (name, description, price, image_path, in_stock) VALUES
('Prenosni računalnik Lenovo', '14-palčni prenosnik z Intel i5 procesorjem', 799.99, 'images/lenovo.jpg', TRUE),

('Brezžična miška Logitech', 'Ergonomska brezžična miška', 29.90, 'images/miska.jpg', TRUE),

('Mehanska tipkovnica', 'RGB mehanska tipkovnica s stikali Blue', 89.50, 'images/tipkovnica.jpg', TRUE),

('Monitor Samsung 27"', '27-palčni IPS monitor Full HD', 199.99, 'images/monitor.jpg', TRUE),

('Slušalke Sony', 'Brezžične slušalke z odpravljanjem šumov', 249.00, 'images/slusalke.jpg', TRUE),

('Zunanji disk 1TB', 'USB 3.0 zunanji trdi disk', 74.99, 'images/disk.jpg', TRUE),

('USB ključ 64GB', 'USB 3.1 ključ 64GB', 12.99, 'images/usb.jpg', TRUE),

('Pametna ura Xiaomi', 'Pametna ura s spremljanjem zdravja', 129.90, 'images/ura.jpg', FALSE),

('Bluetooth zvočnik JBL', 'Prenosni bluetooth zvočnik', 59.99, 'images/zvocnik.jpg', TRUE),

('Web kamera HD', 'HD kamera za video klice', 39.90, 'images/kamera.jpg', TRUE);

INSERT INTO users (first_name, last_name, email, password_hash, role, active) VALUES
('Ana', 'Novak', 'ana.novak@example.com', 'ana', 'ADMIN', TRUE),
('Marko', 'Kovač', 'marko.kovac@example.com', 'marko', 'SELLER', TRUE),
('Petra', 'Zupan', 'petra.zupan@example.com', 'petra', 'CUSTOMER', TRUE),
('Luka', 'Horvat', 'luka.horvat@example.com', 'luka', 'CUSTOMER', TRUE),
('Maja', 'Kralj', 'maja.kralj@example.com', 'maja', 'SELLER', TRUE),
('Tomaž', 'Potočnik', 'tomaz.potocnik@example.com', 'tomaz', 'CUSTOMER', TRUE),
('Nina', 'Vidmar', 'nina.vidmar@example.com', 'nina', 'CUSTOMER', FALSE),
('Gregor', 'Oblak', 'gregor.oblak@example.com', 'gregor', 'SELLER', TRUE),
('Sara', 'Mlakar', 'sara.mlakar@example.com', 'sara', 'CUSTOMER', TRUE),
('Blaž', 'Rozman', 'blaz.rozman@example.com', 'blaz', 'ADMIN', TRUE);

INSERT INTO cart (user_id) VALUES (1);
INSERT INTO cart (user_id) VALUES (2);
INSERT INTO cart (user_id) VALUES (3);
INSERT INTO cart (user_id) VALUES (4);
INSERT INTO cart (user_id) VALUES (5);
INSERT INTO cart (user_id) VALUES (6);
INSERT INTO cart (user_id) VALUES (7);
INSERT INTO cart (user_id) VALUES (8);
INSERT INTO cart (user_id) VALUES (9);
INSERT INTO cart (user_id) VALUES (10);