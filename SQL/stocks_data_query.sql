-- Revisión inicial de tablas
SELECT * FROM "memory"."coin_data.csv";
SELECT * FROM "memory"."goog_data.csv";
SELECT * FROM "memory"."ppta_data.csv";
SELECT * FROM "memory"."soxx_data.csv";
SELECT * FROM "memory"."ual_data.csv";


--Conteo de datos
--Coinbase
SELECT COUNT(fecha) AS coin_data_count
FROM "memory"."coin_data.csv";

--Google
SELECT COUNT(fecha) AS goog_data_count
FROM "memory"."goog_data.csv";

--Perpetua Resources
SELECT COUNT(fecha) AS ppta_data_count
FROM "memory"."ppta_data.csv";

--Philadelfia Semiconductors Index
SELECT COUNT(fecha) AS sox_data_count
FROM "memory"."soxx_data.csv";

--United Airlines
SELECT COUNT(fecha) AS ual_data_count
FROM "memory"."ual_data.csv";


--Revisión de tipos
--Coinbase
DESCRIBE "memory"."coin_data.csv";

--Google
DESCRIBE "memory"."goog_data.csv";

--Perpetua Resources
DESCRIBE "memory"."ppta_data.csv";

--Philadelfia Semoconductors Index
DESCRIBE "memory"."soxx_data.csv";

--United Airlines
DESCRIBE "memory"."ual_data.csv";


--Rango de fechas a utilizar
SELECT
  MIN(fecha) AS inicio,
  MAX(fecha) AS final
FROM "memory"."coin_data.csv";


--Creación de tabla general
CREATE TABLE stocks_data AS  
  SELECT
    coin.fecha,
    coin.cierre AS coin,
    goog.cierre AS goog,
    ppta.cierre AS ppta,
    soxx.cierre AS soxx,
    ual.cierre AS ual 
  FROM "memory"."coin_data.csv" AS coin 
  INNER JOIN "memory"."goog_data.csv" AS goog
    ON coin.fecha = goog.fecha
  INNER JOIN "memory"."ppta_data.csv" AS ppta
    ON coin.fecha = ppta.fecha
  INNER JOIN "memory"."soxx_data.csv" AS soxx
    ON coin.fecha = soxx.fecha
  INNER JOIN "memory"."ual_data.csv" AS ual
    ON coin.fecha = ual.fecha
  ORDER BY coin.fecha ASC;

--Revisión de la nueva tabla
--Número de datos
SELECT COUNT(fecha) FROM stocks_data;

--Detección de duplicados
SELECT COUNT(DISTINCT fecha) FROM stocks_data;

--Rango de fechas
SELECT 
  MIN(fecha) AS inicio,
  MAX(fecha) AS final
FROM stocks_data;

--Tipo de datos
DESCRIBE stocks_data;

--Conteo de nulos
SELECT 
  SUM(CASE WHEN coin ISNULL THEN 1 ELSE 0 END) AS coin_null_count,
  SUM(CASE WHEN goog ISNULL THEN 1 ELSE 0 END) AS goog_null_count,
  SUM(CASE WHEN ppta ISNULL THEN 1 ELSE 0 END) AS ppta_null_count,
  SUM(CASE WHEN soxx ISNULL THEN 1 ELSE 0 END) AS soxx_null_count,
  SUM(CASE WHEN ual ISNULL THEN 1 ELSE 0 END) AS ual_null_count
FROM stocks_data;
