-- ===== BLOQUE 1 – Información inicial del servidor =====
-- Ejercicio 1: Consulta la versión de MySQL y el usuario conectado actualmente.
SELECT VERSION(), CURRENT_USER();

-- Ejercicio 2: Muestra todas las bases de datos disponibles en el servidor.
SHOW DATABASES();

-- Ejercicio 3: Indica cuál es la base de datos en uso en este momento.
SELECT DATABASE();


-- ===== BLOQUE 2 – Creación e inserción básica =====
-- Ejercicio 1: Crea una tabla llamada 'customers' con un identificador y un nombre.
CREATE TABLE customers(id INT PRIMARY KEY, name VARCHAR(100));

-- Ejercicio 2: Inserta un registro en la tabla 'customers'.
INSERT INTO customers VALUES (1,'Ana');

-- Ejercicio 3: Recupera todos los registros almacenados en 'customers'.
SELECT * FROM customers;


-- ===== BLOQUE 3 – Ejemplo de glosario =====
-- Ejercicio 1: Crea una tabla 'glossary_example' para almacenar términos.
CREATE TABLE glossary_example(id INT PRIMARY KEY, term VARCHAR(50));

-- Ejercicio 2: Inserta varios términos relacionados con bases de datos.
INSERT INTO glossary_example VALUES (1,'Tabla'),(2,'Columna'),(3,'Registro');

-- Ejercicio 3: Muestra todos los términos guardados en el glosario.
SELECT * FROM glossary_example;


-- ===== BLOQUE 4 – Administración de usuarios y permisos =====
-- Ejercicio 1: Crea una nueva base de datos llamada 'firstdb'.
CREATE DATABASE firstdb;

-- Ejercicio 2: Crea un usuario llamado 'dev' con contraseña '1234' limitado a localhost.
CREATE USER 'dev'@'localhost' IDENTIFIED BY '1234';

-- Ejercicio 3: Otorga todos los privilegios sobre la base 'firstdb' al usuario 'dev'.
GRANT ALL PRIVILEGES ON firstdb.* TO 'dev'@'localhost';


-- ===== BLOQUE 5 – Modificación de tablas =====
-- Ejercicio 1: Crea la tabla 'person' con id, nombre y edad.
CREATE TABLE person(id INT PRIMARY KEY, name VARCHAR(50), age TINYINT);

-- Ejercicio 2: Agrega un nuevo campo 'email' a la tabla 'person'.
ALTER TABLE person ADD email VARCHAR(100);

-- Ejercicio 3: Inserta un registro completo en la tabla 'person'.
INSERT INTO person VALUES (1,'Luis',30,'luis@mail.com');


-- ===== BLOQUE 6 – Tipos de datos en tablas =====
-- Ejercicio 1: Crea la tabla 'products' con un precio decimal.
CREATE TABLE products(id INT PRIMARY KEY, price DECIMAL(10,2));

-- Ejercicio 2: Crea la tabla 'events' con una fecha.
CREATE TABLE events(id INT PRIMARY KEY, event_date DATE);

-- Ejercicio 3: Crea la tabla 'notes' con un campo de texto libre.
CREATE TABLE notes(id INT PRIMARY KEY, note TEXT);


-- ===== BLOQUE 7 – Inserción de datos =====
-- Ejercicio 1: Inserta un producto con precio específico.
INSERT INTO products VALUES (1,10.50);

-- Ejercicio 2: Inserta múltiples productos en una sola sentencia.
INSERT INTO products VALUES (2,20.00),(3,15.75);

-- Ejercicio 3: Carga datos desde un archivo externo a la tabla 'products'.
LOAD DATA LOCAL INFILE 'products.txt' INTO TABLE products;


-- ===== BLOQUE 8 – Consultas con condiciones =====
-- Ejercicio 1: Selecciona personas mayores de 25 años.
SELECT * FROM person WHERE age > 25;

-- Ejercicio 2: Selecciona personas cuyo nombre empieza con 'L'.
SELECT * FROM person WHERE name LIKE 'L%';

-- Ejercicio 3: Limita la salida a los primeros 2 registros.
SELECT * FROM person LIMIT 2;


-- ===== BLOQUE 9 – Funciones de agregación =====
-- Ejercicio 1: Calcula el promedio de los precios en 'products'.
SELECT AVG(price) FROM products;

-- Ejercicio 2: Agrupa productos por precio y cuenta cuántos hay en cada grupo.
SELECT price, COUNT(*) FROM products GROUP BY price;

-- Ejercicio 3: Suma todos los precios de los productos.
SELECT SUM(price) FROM products;


-- ===== BLOQUE 10 – Actualización y eliminación =====
-- Ejercicio 1: Actualiza el precio del producto con id=1.
UPDATE products SET price = 9.99 WHERE id = 1;

-- Ejercicio 2: Elimina el producto con id=3.
DELETE FROM products WHERE id = 3;

-- Ejercicio 3: Agrega un campo 'stock' con valor por defecto 0.
ALTER TABLE products ADD stock INT DEFAULT 0;


-- ===== BLOQUE 11 – Relaciones y JOIN =====
-- Ejercicio 1: Crea tablas 'category' e 'item' con relación de clave foránea.
CREATE TABLE category(id INT PRIMARY KEY, name VARCHAR(50));
CREATE TABLE item(id INT PRIMARY KEY, name VARCHAR(50), category_id INT, FOREIGN KEY(category_id) REFERENCES category(id));

-- Ejercicio 2: Une 'item' con 'category' mostrando nombre de ítem y categoría.
SELECT i.name, c.name FROM item i JOIN category c ON i.category_id = c.id;

-- Ejercicio 3: Usa LEFT JOIN para mostrar todas las categorías aunque no tengan ítems.
SELECT c.name, i.name FROM category c LEFT JOIN item i ON c.id = i.category_id;


-- ===== BLOQUE 12 – Índices =====
-- Ejercicio 1: Crea un índice en el campo 'name' de la tabla 'person'.
CREATE INDEX idx_name ON person(name);

-- Ejercicio 2: Analiza cómo se ejecuta una consulta usando EXPLAIN.
EXPLAIN SELECT * FROM person WHERE name='Luis';

-- Ejercicio 3: Elimina el índice creado anteriormente.
DROP INDEX idx_name ON person;


-- ===== BLOQUE 13 – Transacciones =====
-- Ejercicio 1: Inicia una transacción manual.
START TRANSACTION;

-- Ejercicio 2: Simula una transferencia entre cuentas y confirma con COMMIT.
UPDATE accounts SET balance=balance-100 WHERE id=1;
UPDATE accounts SET balance=balance+100 WHERE id=2;
COMMIT;

-- Ejercicio 3: Revierte cambios pendientes con ROLLBACK.
ROLLBACK;


-- ===== BLOQUE 14 – Motores de almacenamiento =====
-- Ejercicio 1: Crea tabla con motor InnoDB (soporta transacciones).
CREATE TABLE tbl_a(id INT PRIMARY KEY) ENGINE=InnoDB;

-- Ejercicio 2: Crea tabla con motor MyISAM (rápido pero sin transacciones).
CREATE TABLE tbl_b(id INT PRIMARY KEY) ENGINE=MyISAM;

-- Ejercicio 3: Crea tabla con motor MEMORY (datos en RAM, volátil).
CREATE TABLE tbl_c(id INT PRIMARY KEY) ENGINE=MEMORY;


-- ===== BLOQUE 15 – Variables, procedimientos y triggers =====
-- Ejercicio 1: Usa una variable para numerar registros de 'products'.
SET @counter = 0;
SELECT @counter := @counter + 1 FROM products;

-- Ejercicio 2: Crea un procedimiento almacenado que devuelve todos los productos.
DELIMITER //
CREATE PROCEDURE get_products()
BEGIN
  SELECT * FROM products;
END //
DELIMITER ;

-- Ejercicio 3: Crea un trigger que registra inserciones en 'products' dentro de 'notes'.
DELIMITER //
CREATE TRIGGER log_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO notes(id,note) VALUES(NEW.id,'Producto agregado');
END //
DELIMITER ;


-- ===== BLOQUE 16 – Monitoreo y rendimiento =====
-- Ejercicio 1: Muestra los procesos activos en el servidor.
SHOW PROCESSLIST;

-- Ejercicio 2: Consulta el estado global de hilos en ejecución.
SHOW GLOBAL STATUS LIKE 'Threads%';

-- Ejercicio 3: Activa el perfilado, ejecuta una consulta y muestra estadísticas.
SET PROFILING = 1;
SELECT SLEEP(1);
SHOW PROFILES;


-- ===== BLOQUE 17 – Copias de seguridad y restauración =====
-- Ejercicio 1: Genera un respaldo de la base 'firstdb' en un archivo SQL.
-- mysqldump -u root -p firstdb > firstdb.sql

-- Ejercicio 2: Restaura la base de datos desde el archivo de respaldo.
-- mysql -u root -p < firstdb.sql

-- Ejercicio 3: Crea un esquema con tablas relacionadas: clientes, pedidos, productos y detalle.
CREATE TABLE clientes(id INT PRIMARY KEY, nombre VARCHAR(100));
CREATE TABLE pedidos(id INT PRIMARY KEY, cliente_id INT, FOREIGN KEY(cliente_id) REFERENCES clientes(id));
CREATE TABLE productos(id INT PRIMARY KEY, nombre VARCHAR(100));
CREATE TABLE detalle(id_pedido INT, id_producto INT, cantidad INT,
  FOREIGN KEY(id_pedido) REFERENCES pedidos(id),
  FOREIGN KEY(id_producto) REFERENCES productos(id));
