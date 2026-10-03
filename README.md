# 📉 Análisis de series financieras: evaluación de riesgo con Value at Risk (VaR)

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Limpieza%20y%20construcción-4479A1?logo=postgresql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Análisis-150458?logo=pandas&logoColor=white)
![Statsmodels](https://img.shields.io/badge/Statsmodels-ARIMA-4B8BBE)
![ARCH](https://img.shields.io/badge/arch-GARCH-orange)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)
![Estado](https://img.shields.io/badge/Estado-Completado-success)

## 📌 Descripción del proyecto

Análisis de series temporales financieras orientado a la **modelación y pronóstico de volatilidad condicional**, la **evaluación fuera de muestra** y la **medición dinámica del riesgo** mediante **Value at Risk (VaR)**.

El proyecto toma cinco activos de sectores distintos (criptomonedas, tecnología, minería, semiconductores y aerolíneas), construye el dataset mediante SQL y recorre el flujo completo: análisis descriptivo, rendimientos, drawdown, volatilidad, correlación, beta, modelos ARIMA y GARCH, pronósticos y backtesting formal del VaR.

---

## 🎯 Objetivos

- Construir y depurar los datasets de precios de cierre mediante **SQL**.
- Caracterizar el comportamiento estadístico de los activos (rendimientos, drawdown, volatilidad y sensibilidad al mercado).
- Modelar la media (ARIMA) y la varianza condicional (GARCH) de los rendimientos logarítmicos.
- Evaluar la capacidad predictiva de los modelos **fuera de muestra** con ventana expansiva.
- Calcular un **VaR dinámico al 95%** y validarlo con pruebas de Kupiec y Christoffersen.

---

## 🔄 Flujo metodológico

**Limpieza y construcción del dataset (SQL)** → Análisis descriptivo → Rendimientos → Drawdown → Análisis de volatilidad → Correlación de activos → Beta → Autocorrelación → ARIMA → GARCH → Volatilidad condicional → Pronósticos de volatilidad → VaR

| Fase | Descripción |
|------|-------------|
| 🗄️ **1. Limpieza y construcción (SQL)** | Depuración, validación y unificación de las series de precios en los datasets finales (`stocks_data.csv` y `sp_data.csv`). |
| 🔍 **2. Análisis descriptivo** | Inspección inicial, estadísticas descriptivas y comportamiento de precios en escala lineal y logarítmica. |
| 📈 **3. Rendimientos** | Rendimientos logarítmicos, retorno acumulado, retorno anualizado y análisis de distribución (asimetría y curtosis). |
| 🔻 **4. Drawdown** | Precios máximos/mínimos y caída máxima desde picos históricos. |
| 🌪️ **5. Volatilidad** | Volatilidad histórica diaria y anualizada, volatilidad móvil (20, 60 y 120 días) y eventos de alta volatilidad (percentil 90). |
| 🔗 **6. Correlación y Beta** | Matriz de correlación de Pearson, gráfico de pares, beta frente al S&P 500 y beta móvil. |
| 🔁 **7. Autocorrelación** | Pruebas de estacionariedad (ADF y KPSS) y funciones ACF/PACF. |
| 🧮 **8. ARIMA** | Selección de modelos por AIC/BIC/HQIC y diagnóstico de residuos (Ljung-Box). |
| ⚡ **9. GARCH** | Pruebas ARCH-LM, estimación de modelos GARCH(p,q) y validación de residuos. |
| 🔮 **10. Pronósticos** | Volatilidad condicional y pronóstico fuera de muestra con *expanding window* (80% entrenamiento / 20% prueba). |
| 🛡️ **11. VaR** | VaR dinámico al 95% y backtesting (tasa de excedencias, Kupiec, Christoffersen y prueba conjunta). |

---

## 🗂️ Diccionario de datos

### `stocks_data.csv`

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `Fecha` | datetime | Fecha de cada sesión de mercado entre el 15/04/2021 y el 21/09/2026 (índice del dataset). |
| `coin` | float | Precio al cierre de Coinbase Inc., plataforma de comercio de criptomonedas. |
| `goog` | float | Precio al cierre de Alphabet Inc. (Clase C), empresa matriz de Google. |
| `ppta` | float | Precio al cierre de Perpetua Resources Corp., minera de oro y antimonio. |
| `soxx` | float | Precio al cierre del iShares Semiconductor ETF (BlackRock), indexado al Philadelphia Semiconductors Index. |
| `ual` | float | Precio al cierre de United Airlines Holdings, Inc. |

### `sp_data.csv`

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `Fecha` | datetime | Fecha de cada sesión de mercado entre el 15/04/2021 y el 21/09/2026 (índice del dataset). |
| `sp500` | float | Valor al cierre del índice S&P 500, utilizado como *benchmark* para el cálculo de beta. |

> 📊 **Volumen:** 1,365 sesiones de mercado, sin valores nulos ni duplicados.

---

## 🔑 Resultados clave

### Situación
Los cinco activos pertenecen a sectores con dinámicas de riesgo muy distintas y presentan volatilidades altas (entre 1.96% y 5.31% diario). Medir el riesgo con una desviación estándar histórica única no refleja que la volatilidad cambia en el tiempo.

### Complicación
Los rendimientos no siguen una distribución normal: muestran colas pesadas, *volatility clustering* y drawdowns máximos elevados. Además, la volatilidad móvil es retrospectiva y no ofrece pronósticos, y la sensibilidad al mercado es inestable (por ejemplo, la beta móvil de `ppta` oscila entre 7.24 y -7.65 en ventanas de 20 días).

### Pregunta
¿Es posible estimar la volatilidad condicional de cada activo, pronosticarla fuera de muestra y convertirla en un VaR dinámico que cumpla las pruebas formales de cobertura e independencia?

### Respuesta

- **Volatilidad:** `coin` es el activo más volátil (5.31% diario, 84.33% anualizado), seguido de `ppta` (4.46% diario, 70.80% anualizado). `goog` es el más estable (1.96% diario).
- **Rentabilidad vs. riesgo:** `goog` y `soxx` ofrecen la mejor recompensa por unidad de riesgo (0.6642 y 0.6525). `coin` es el único activo con rendimiento acumulado negativo.
- **Sensibilidad al mercado:** `coin` tiene la beta más alta (2.69) y `ppta` la más baja (1.19), ambas por encima de 1.
- **Correlación:** relación débil entre la mayoría de los pares; la única moderada es `goog`–`soxx` (0.51), ambos del sector tecnológico. No hay señales de colinealidad.
- **Estacionariedad:** las pruebas ADF y KPSS confirman que los cinco rendimientos son estacionarios; ARIMA aporta poca estructura a la media (excepto en `soxx`, con ARIMA(0,0,4)).
- **GARCH:** efecto ARCH significativo en los cinco activos. Modelos seleccionados: GARCH(2,1) para `coin` y GARCH(1,1) para `goog`, `ppta`, `soxx` y `ual`. Los residuos de los cinco modelos pasan Ljung-Box y ARCH-LM.
- **Pronóstico fuera de muestra:** `ual` y `soxx` obtuvieron los resultados más consistentes; `coin` y `goog` tuvieron mayores dificultades en episodios extremos. Durante los periodos de alta volatilidad la precisión de todos los modelos disminuye.
- **VaR al 95%:** ninguno de los cinco modelos rechaza conjuntamente las pruebas de cobertura (Kupiec) e independencia (Christoffersen), lo que respalda su utilidad para la medición de riesgo, con distintos grados de confianza según el activo (`goog` es el único que no pasa Kupiec de forma individual).

| Criterio | COIN | GOOG | PPTA | SOXX | UAL |
|----------|------|------|------|------|-----|
| Modelo seleccionado | GARCH(2,1) | GARCH(1,1) | GARCH(1,1) | GARCH(1,1) | GARCH(1,1) |
| Parámetros plenamente significativos | ⚠️ No | ⚠️ No | ⚠️ No | ✅ Sí | ✅ Sí |
| Desempeño fuera de muestra | ⚠️ | ❌ | ⚠️ | ✅ | ✅ |
| Kupiec 95% | ✅ | ❌ | ✅ | ✅ | ✅ |
| Independencia (Christoffersen) | ✅ | ✅ | ✅ | ✅ | ✅ |
| Prueba conjunta | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## 🛠️ Tecnologías utilizadas

| Categoría | Herramientas |
|-----------|--------------|
| Lenguajes | Python, SQL |
| Manipulación de datos | `pandas`, `numpy` |
| Visualización | `matplotlib`, `seaborn` |
| Series temporales | `statsmodels` (ADF, KPSS, ACF/PACF, ARIMA, Ljung-Box, ARCH-LM) |
| Volatilidad | `arch` (modelos GARCH) |
| Estadística y métricas | `scipy.stats`, `scikit-learn` |
| Entorno | Jupyter Notebook |

---

## 📁 Estructura del repositorio

```
📦 Stock_analysis_Risk_evaluation_using_VaR
├── 📂 DATA
│   ├── 📂 CLEAN_DATA
|   |    ├── stocks_data.csv
|   |    └── sp_data.csv
│   └── 📂 RAW_DATA
|        ├── coin_data.csv
|        ├── goog_data.csv
|        ├── ppta_data.csv
|        ├── soxx_data.csv
|        ├── sp500_data.csv
|        └── ual_data.csv
├── 📂 NOTEBOOKS
│    └── Stock_Analysis.ipynb
├── 📂 SQL
|    ├── stocks_data.csv
│    └── sp_data.csv
├── 📄 LICENSE
└── 📄 README.md
```

---

## ▶️ Cómo reproducir el análisis

1. Clona el repositorio:
   ```bash
   git clone https://github.com/alexisjmz88/Stock_analysis_Risk_evaluation_using_VaR.git
   ```
2. Ejecuta los scripts de la carpeta `SQL/` para construir los datasets (o utiliza directamente los CSV de `DATA/CLEAN_DATA/`).
3. Instala las dependencias:
   ```bash
   pip install pandas numpy matplotlib seaborn statsmodels scikit-learn scipy arch
   ```
4. Abre y ejecuta `NOTEBOOKS/Stock_Analysis.ipynb`.

---

## ⚠️ Consideraciones

- Este proyecto tiene fines académicos y de portafolio; no constituye una recomendación de inversión.
- El VaR se calculó al 95% de confianza bajo el supuesto de distribución normal y media cero. La muestra de evaluación (273 observaciones) es pequeña, por lo que las pruebas de backtesting deben interpretarse con cautela.

---

## 📄 Licencia

Este proyecto se distribuye bajo la licencia **MIT**. Consulta el archivo [LICENSE](LICENSE) para más detalles.
