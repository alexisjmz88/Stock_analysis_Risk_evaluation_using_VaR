-- Revisión inicial de tabla
SELECT * FROM "memory"."coin_data.csv";
SELECT * FROM "memory"."sp500_data.csv";


--Conteo de datos
--Coinbase
SELECT COUNT(fecha) AS coin_data_count
FROM "memory"."coin_data.csv";

--S&P 500
SELECT COUNT(fecha) AS goog_data_count
FROM "memory"."sp500_data.csv";


--Revisión de tipos
--Coinbase
DESCRIBE "memory"."coin_data.csv";

--S&P 500
DESCRIBE "memory"."sp500_data.csv";


--Rango de fechas a utilizar
SELECT
  MIN(fecha) AS inicio,
  MAX(fecha) AS final
FROM "memory"."coin_data.csv";


--Creación de tabla general
CREATE TABLE sp_data AS  
  SELECT
    coin.fecha,
    REPLACE(sp500.cierre, ',', '') AS sp500
  FROM "memory"."coin_data.csv" AS coin 
  INNER JOIN "memory"."sp500_data.csv" AS sp500
    ON coin.fecha = sp500.fecha
  ORDER BY coin.fecha ASC;

--Revisión de la nueva tabla
--Número de datos
SELECT COUNT(fecha) FROM sp_data;

--Detección de duplicados
SELECT COUNT(DISTINCT fecha) FROM sp_data;

--Rango de fechas
SELECT 
  MIN(fecha) AS inicio,
  MAX(fecha) AS final
FROM sp_data;

--Tipo de datos
DESCRIBE sp_data;

--Corrección de tipo de dato
ALTER TABLE sp_data
ALTER COLUMN sp500 TYPE DOUBLE PRECISION USING sp500::double precision;

--Conteo de nulos
SELECT 
  SUM(CASE WHEN sp500 ISNULL THEN 1 ELSE 0 END) AS sp500_null_count,
FROM sp_data;
