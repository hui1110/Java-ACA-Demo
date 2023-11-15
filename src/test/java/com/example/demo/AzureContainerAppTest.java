package com.example.demo;

import com.azure.core.credential.AccessToken;
import com.azure.core.credential.TokenCredential;
import com.azure.core.credential.TokenRequestContext;
import com.azure.core.management.AzureEnvironment;
import com.azure.core.management.profile.AzureProfile;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.resourcemanager.appcontainers.ContainerAppsApiManager;
import com.azure.resourcemanager.appcontainers.models.ContainerApp;
import org.junit.jupiter.api.Test;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Assert;
import org.springframework.web.client.RestTemplate;
import reactor.core.publisher.Mono;

import java.time.OffsetDateTime;
import java.util.Objects;

public class AzureContainerAppTest {

    private static final String RESOURCE_GROUP = "armacatest";
    private static final String CONTAINER_APP_NAME = "app-armacatest";
    private static final String TENANT_ID = "72f988bf-86f1-41af-91ab-2d7cd011db47";
    private static final String SUBSCRIPTION_ID = "799c12ba-353c-44a1-883d-84808ebb2216";

    @Test
    void testCreatedContainerApp() {
        AzureProfile profile = new AzureProfile(TENANT_ID, SUBSCRIPTION_ID, AzureEnvironment.AZURE);

        TokenCredential tokenCredential = new DefaultAzureCredentialBuilder().build();
        TokenRequestContext request = new TokenRequestContext().addScopes("https://management.azure.com/.default");
        AccessToken token =
                tokenCredential.getToken(request).retry(3L).blockOptional().orElseThrow(() -> new RuntimeException(
                        "Couldn't retrieve JWT"));
        TokenCredential credential = toTokenCredential(token.getToken());

        ContainerAppsApiManager manager = ContainerAppsApiManager
                .authenticate(credential, profile);

        ContainerApp containerApp = manager.containerApps().getByResourceGroup(RESOURCE_GROUP, CONTAINER_APP_NAME);
        RestTemplate restTemplate = new RestTemplate();

        String controllerUrl = String.format("https://%s/hello", containerApp.innerModel().configuration().ingress().fqdn());
        ResponseEntity<String> controllerResponse = restTemplate.getForEntity(controllerUrl, String.class);
        Assert.isTrue(Objects.equals(controllerResponse.getBody(), "Hello World! Java 8"), "Response body is not expected");

        String attachUrl = String.format("https://%s/attach", containerApp.innerModel().configuration().ingress().fqdn());
        ResponseEntity<String> attachResponse = restTemplate.getForEntity(attachUrl, String.class);
        Assert.isTrue(Objects.equals(attachResponse.getStatusCode().toString(), "200"), "Response status is not expected");

    }

    private static TokenCredential toTokenCredential(String accessToken) {
        return request -> Mono.just(new AccessToken(accessToken, OffsetDateTime.MAX));
    }

}
