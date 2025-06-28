# Reto Técnico QA Backend - ServeRest API

Este proyecto contiene una suite de pruebas automatizadas para validar la API de Usuarios del sistema [ServeRest](https://serverest.dev/) utilizando **Karate DSL**. Las pruebas cubren operaciones CRUD, validaciones de esquema JSON y manejo de datos dinámicos.

----
## 🚀 Requisitos

- Java 11 o 17 (LTS recomendado)
- Maven 3.8.6 o superior

---
## 🧰 Dependencias

* Karate DSL 1.4.1
* JUnit 5
* Maven Surefire Plugin
* Cucumber Reporting (Masterthought)

---

## 📦 Cómo clonar y ejecutar

```bash
git clone https://github.com/PaulSuyCa/retoTecnicoQa-BackEnd-Pacifico.git
cd retoTecnicoQa-BackEnd-Pacifico
mvn clean test
```

## 🗂️ Estructura del proyecto

```
src/test/java/
├── features/
│   └── usuarios/               # Features para cada endpoint CRUD
│   └── runner/                 # Clase runner para ejecución con tags
├── helpers/                    # JS o Java para generación de datos
src/test/resources/
├── schemas/                    # Validación de respuestas JSON
karate-config.js                # Configuración de entornos
pom.xml                         # Configuración de dependencias

```

## ⚙️ Ejecución de pruebas

Ejecución básica:

```bash
mvn clean test
```

Ejecución por entorno:

```bash
mvn clean test "-Dkarate.env=cert"
```

Por defecto usa el entorno `dev` si no se especifica.

---

## 📍 Ejecución por tags

El runner está filtrando los tests por el tag `@ServerUsuarios`:

```bash
mvn clean test "-Dkarate.env=cert" -Dkarate.options="--tags @ServerUsuarios"
```

Puedes cambiar o agregar tags según lo necesites.

---
## 🔄 Runner principal

```java
Results results = Runner.path("classpath:features")
        .tags("@ServerUsuarios")
        .outputCucumberJson(true)
        .parallel(1);
```

## 📈 Reportes

* Reportes Cucumber HTML:

```
target/cucumber-html-reports/
```

* Logs de ejecución:

```
target/surefire-reports/
```