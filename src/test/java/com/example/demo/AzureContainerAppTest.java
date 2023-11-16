package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.client.RestTemplate;

import java.util.Objects;

public class AzureContainerAppTest {
    private static final String FQDN = "app-armacatest--revision.bluemoss-dc4559ed.eastus.azurecontainerapps.io";

    @Test
    void testCreatedContainerApp() {
        RestTemplate restTemplate = new RestTemplate();

        String url = String.format("https://%s/hello", FQDN);
        ResponseEntity<String> controllerResponse = restTemplate.getForEntity(url, String.class);
        Assert.isTrue(Objects.equals(controllerResponse.getBody(), "Hello World! Java 8"), "Response body is not expected");

        String attachUrl = String.format("https://%s/attach", FQDN);
        ResponseEntity<String> attachResponse = restTemplate.getForEntity(attachUrl, String.class);
        Assert.isTrue(Objects.equals(attachResponse.getStatusCode(), HttpStatus.OK), "Response status is not expected");
    }

}
