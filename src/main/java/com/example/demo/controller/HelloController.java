package com.example.demo.controller;

import com.sun.tools.attach.VirtualMachine;
import com.sun.tools.attach.VirtualMachineDescriptor;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.util.List;

@RestController
public class HelloController {

    String AGENT_ARGS = "/app.jar";

    String AGENT_PATH = "https://huiagentaccount.blob.core.windows.net/agent-8/java-accelerator-agent-0.0.1-SNAPSHOT.jar";

    @GetMapping("/hello")
    public String hello() {
        return "Hello World! Java 8";
    }

    @RequestMapping(value = "/attach", method = RequestMethod.GET)
    public String updateClassMethod(){
        try {
            String agentFilePath = downloadAgentJar().getAbsolutePath();
            List<VirtualMachineDescriptor> list = VirtualMachine.list();
            for (VirtualMachineDescriptor vmd : list) {
                if (vmd.displayName().equals(AGENT_ARGS)) {
                    System.out.println("find agent process");
                    VirtualMachine virtualMachine = VirtualMachine.attach(vmd.id());
                    virtualMachine.loadAgent(agentFilePath);
                    virtualMachine.detach();
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "attach success";
    }

    private File downloadAgentJar() throws IOException, URISyntaxException {
        String[] split = AGENT_PATH.split("/");
        String fileName = split[split.length - 1];
        File file = new File(fileName);
        if (file.exists()) {
            file.delete();
        }
        HttpURLConnection connection = (HttpURLConnection) new URI(AGENT_PATH).toURL().openConnection();
        connection.connect();
        try (InputStream inputStream = connection.getInputStream();
             OutputStream outputStream = Files.newOutputStream(file.toPath())) {
            IOUtils.copy(inputStream, outputStream);
        } finally {
            connection.disconnect();
        }
        System.out.println("---download agent jar success---");
        return file;
    }

}
