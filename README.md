# retoTecnicoQa-BackEnd-Pacifico

## 🚀 Requisitos

* Java 11 o 17 (LTS recomendado)
* Maven 3.8.6 o superior

---

## 🔧 Estructura del proyecto

* `src/test/java/features/` → Features de prueba en Karate DSL.
* `src/test/java/features/runner/` → Contiene el `runnerTest.java` para ejecutar los tests.
* `src/test/resources/` → Archivos de datos de prueba.
* `karate-config.js` → Archivo de configuración de entornos.

---

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

```java
.tags("@ServerUsuarios")
```

Puedes cambiar o agregar tags según lo necesites.

---

## 📈 Reportes

* Reportes Cucumber HTML:

```
target/cucumber-html-reports/
```

* Logs de ejecución:

```
target/surefire-reports/
```

---

## 🧰 Dependencias

* Karate DSL 1.4.1
* JUnit 5
* Maven Surefire Plugin
* Cucumber Reporting (Masterthought)

---

## 🔄 Runner principal

```java
Results results = Runner.path("classpath:features")
        .tags("@ServerUsuarios")
        .outputCucumberJson(true)
        .parallel(1);
```

---