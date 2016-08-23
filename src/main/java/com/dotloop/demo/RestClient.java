package com.dotloop.demo;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;


import java.io.IOException;
import java.net.URI;
import java.util.Map;

@Component
public class RestClient {
    private static final Logger log = LoggerFactory.getLogger(Application.class);

    public String get(String url, Map<String, String> payload, HttpHeaders httpRequestHeaders) {
        log.info("Calling " + url);
        RestTemplate restTemplate = new RestTemplate();
        HttpEntity requestEntity = new HttpEntity(payload, httpRequestHeaders);
        ResponseEntity response = restTemplate.exchange(
        url,
        HttpMethod.GET,
        requestEntity,
        String.class);
        String result = (String)response.getBody();
        return result;
    }

    public String post(String url, Map<String, String> payload, Map<String, String> headers) {
        log.info("Making POST request to " + url);
        String result = null;
        CloseableHttpClient httpclient = HttpClients.custom().build();
        try {
             RequestBuilder builder = RequestBuilder.post()
                    .setUri(new URI(url));
            for(String s : payload.keySet()) {
                builder.addParameter(s, payload.get(s));
            }
            HttpUriRequest request = builder.build();
            for(String h : headers.keySet()) {
                request.addHeader(h, headers.get(h));
            }
            CloseableHttpResponse response2 = httpclient.execute(request);
            try {
                org.apache.http.HttpEntity entity = response2.getEntity();
                //log.info("ENTITY:" + entity.toString());
                log.info("return status code: " + response2.getStatusLine());

                result = EntityUtils.toString(entity);
            } finally {
                response2.close();
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                httpclient.close();
            } catch(IOException ioe) {
                throw new RuntimeException(ioe);
            }
        }

        return result;
    }
}
