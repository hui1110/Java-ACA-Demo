package com.example.demo.controller;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.LoggerContext;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HelloController {

    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(HelloController.class);

    @GetMapping("/hello")
    public String hello() {
        LOGGER.debug("Debug hello world");
        return "hello world";
    }

    @GetMapping("/logger")
    public Object getLogger() {
        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
        return loggerContext.getLoggerList().stream().filter(logger ->
                logger.getName().equals(HelloController.class.getName())).map(logger -> {
            Map<String, String> loggerMap = new java.util.HashMap<>();
            loggerMap.put("name", logger.getName());
            loggerMap.put("level", logger.getLevel().toString());
            return loggerMap;
        }).collect(java.util.stream.Collectors.toList());
    }

    @GetMapping(path = "/updateLogLevel")
    public String updateLogLevel(@RequestParam("level") String level) {
        final String loggerName = HelloController.class.getName();
        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
        Logger logger = loggerContext.getLogger(loggerName);
        Level newLevel = Level.toLevel(level, null);
        logger.setLevel(newLevel);
        return "OK";
    }

}
