package runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class runnerTest {
    //Generación de reporte Cucumber
    private void generateCucumberReport(String karateOutputPath) {
        Collection<File> jsonFiles = org.apache.commons.io.FileUtils.listFiles(
                new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));

        Configuration config = new Configuration(new File("target"), "Karate Test");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    // Configurar el ambiente antes de cada prueba
    @BeforeEach
    public void setUpEnvironment() {
        // Cambia "dev" o "cert" al ambiente que deseas ejecutar
        System.setProperty("karate.env", System.getProperty("karate.env", "cert"));
    }

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                .tags("@ServerUsuarios")
                .outputCucumberJson(true)
                .parallel(2);
        generateCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
