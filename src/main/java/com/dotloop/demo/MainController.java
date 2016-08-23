package com.dotloop.demo;

import com.dotloop.demo.dao.UserRepository;
import com.dotloop.demo.domain.User;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.*;
import org.springframework.http.MediaType;
import org.springframework.stereotype.*;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@EnableAutoConfiguration
public class MainController {
    private static final Logger log = LoggerFactory.getLogger(Application.class);
    private static final String SUCCESS = "SUCCESS";
    private static final String LOOP_NAME = "loop";

    @Value("${dotloop_url}")
    private String REMOTE_URL;

    @Value("${client_id}")
    private String clientId;

    @Value("${client_secret}")
    private String clientSecret;

    @Value("${redirect_url}")
    private String redirectUrl;

    @Value("${url_token")
    private String urlToken;

    @Value("${url_create_loop}")
    private String urlCreateLoop;


//    @Autowired
//    AuthenticationManager authenticationManager;
//
    @Autowired
    UserRepository userRepository;

    @Autowired
    RestClient restClient;

    @RequestMapping({"/", "/home"})
    String home(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        User user = (User)session.getAttribute("user");
        log.info("redirectUrl: " + redirectUrl);
        log.info("clientId:" + clientId);
        session.setAttribute("redirectUrl", redirectUrl);
        session.setAttribute("clientId", clientId);
        session.setAttribute("token", (user != null ? user.getToken() : ""));
        return "home";
    }

    @RequestMapping(value = "/register")
    String register() {
        return "register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    String registered(@RequestBody User user) {
        //log.debug(user);
        return "redirect:/";
    }

    @RequestMapping(value = "/signin", method = RequestMethod.GET)
    String signinRedirect() {
        return "redirect:/";
    }
    @RequestMapping(value = "/signin", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    String signin(HttpServletRequest request, @RequestParam String email, @RequestParam String password) {
//        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(email, password);
//
//        // Authenticate the user
//        Authentication authentication = authenticationManager.authenticate(authRequest);
//        SecurityContext securityContext = SecurityContextHolder.getContext();
//        securityContext.setAuthentication(authentication);
//
//        // Create a new session and add the security context.
//        HttpSession session = request.getSession(true);
//        session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

        log.info("email=" + email);
        HttpSession session = request.getSession(true);
        session.setAttribute("redirectUrl", redirectUrl);
        session.setAttribute("clientId", clientId);
        session.setAttribute("user", userRepository.findByUsername("pierrel@dotloop.com").get(0));
        return "home";
    }

    @RequestMapping("/signout")
    String signout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        log.debug("Signing out");
        return "redirect:/";
    }

    @RequestMapping(value = "/loopit", method = RequestMethod.GET)
    String loopitGet() {
        return "redirect:/";
    }

    @ResponseBody
    @RequestMapping(value = "/loopit", method = RequestMethod.POST)
    String loopit(@CookieValue("JSESSIONID") String cookie, HttpServletRequest request, @RequestBody MultiValueMap<String, String> loop) {
        log.info("Called loopit with name: " + loop.get("loopName").get(0));
        User user = (User)request.getSession().getAttribute("user");
        log.info("TOKEN=" + user.getToken());
        if(user.getToken() == null)
            return "{ \"token\": false }";
        String name = "NOT CREATED";
        if(user.getToken() == null || user.getToken().length() == 0) {
//            Map<String, String> params = new HashMap<>();
//            params.put("email", user.getUsername());
//            params.put("CLIENT_ID", clientId);
//            HttpHeaders requestHeaders = new HttpHeaders();
//            requestHeaders.add("Cookie", "JSESSIONID=" + cookie);
//            String result = restClient.get(REMOTE_URL + "/oauth2/authorize?response_type=code&client_id=${CLIENT_ID}&scopes=loops:*,profiles:*&redirect_uri=http://mandp:9999/authorize?code=__CODE__", params, requestHeaders);
        } else {
            Map<String, String> data = new HashMap<>();
            data.put("loopName", loop.get("loopName").get(0));
            name = createLoop(user.getToken(), data);
            request.getSession().setAttribute(LOOP_NAME, name);
        }
        request.getSession().setAttribute(LOOP_NAME, name);
        return "{ \"name\": \"" + name + "\"," +
                " \"token\": true }";
    }

    @RequestMapping("/authorize")
    String authorize(HttpServletRequest request, @RequestParam String code) {
        User user = (User)request.getSession().getAttribute("user");
        user.setCode(code);
        userRepository.save(user);
        // make http call to dotloop
        Map<String, String> map = new HashMap<>();
        map.put("code", code);
        map.put("grant_type",  "authorization_code");
        map.put("redirect_uri", redirectUrl);
        map.put("client_id", clientId);
        map.put("client_secret", clientSecret);
        String result = restClient.post(REMOTE_URL + "/oauth2/token", map, new HashMap<String, String>());
        JSONObject obj = new JSONObject(result);
        String token = obj.getString("access_token");
        log.info("##### TOKEN=" + token);
        user.setToken(token);
        userRepository.save(user);
        return "loop";
    }

    private String createLoop(String token, Map<String, String> data) {
        Map<String, String> headers = new HashMap<>();
        headers.put("Authorization", "Bearer " + token);
        headers.put("Accept", "*/*");
        //headers.put("Content-Type", "application/json");
        log.info("Create a loop using token: " + token);
        String result = restClient.post(urlCreateLoop, data, headers);
        JSONObject obj = new JSONObject(result);
        String name = obj.getString("loopName");
        log.info("Name of loop: " + name);
        return name;
    }

    @RequestMapping("/revoke")
    String revoke(HttpServletRequest request) {
        User user = (User)request.getSession().getAttribute("user");
        user.setToken(null);
        userRepository.save(user);
        log.info("Token deleted");
        return "redirect:/";
    }
}
