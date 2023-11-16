package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.client.RestTemplate;

import java.util.Objects;

public class AzureContainerAppTest {
    private static final String FQDN = "app-armacait001--revision.agreeableplant-fac9d640.eastus.azurecontainerapps.io";

    @Test
    void testCreatedContainerApp() {
        RestTemplate restTemplate = new RestTemplate();

        String premainUrl = String.format("https://%s/premain", FQDN);
        ResponseEntity<String> premainResponse = restTemplate.getForEntity(premainUrl, String.class);
        Assert.isTrue(Objects.equals(premainResponse.getBody(), "premain method changed"), "Response body is not expected");

        String agentmainurl = String.format("https://%s/agentmain", FQDN);
        ResponseEntity<String> agentmainResponse = restTemplate.getForEntity(agentmainurl, String.class);
        Assert.isTrue(Objects.equals(agentmainResponse.getBody(), "agentmain method"), "Response body is not expected");

        String attachUrl = String.format("https://%s/attach", FQDN);
        ResponseEntity<String> attachResponse = restTemplate.getForEntity(attachUrl, String.class);
        Assert.isTrue(Objects.equals(attachResponse.getBody(), "attach success"), "Response body is not expected");

        ResponseEntity<String> agentmainChangeResponse = restTemplate.getForEntity(agentmainurl, String.class);
        Assert.isTrue(Objects.equals(agentmainChangeResponse.getBody(), "agentmain method changed"), "Response body is not expected");
    }

}
