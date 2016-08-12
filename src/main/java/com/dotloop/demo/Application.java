package com.dotloop.demo;

import com.dotloop.demo.dao.UserRepository;
import com.dotloop.demo.domain.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan
@EnableAutoConfiguration
public class Application extends SpringBootServletInitializer {

    private static final Logger log = LoggerFactory.getLogger(Application.class);

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);

    }

    @Bean
    public CommandLineRunner demo(UserRepository repository) {
			return (args) -> {
                // fetch an individual customer by ID
                User user = repository.findOne(1L);
                if(user != null) {
					log.info("Customer found with findOne(1L):");
					log.info("--------------------------------");
					log.info(user.toString());
					log.info("");
				} else {
					repository.save(new User("pierrel@dotloop.com", "Pierre", "Lourens"));
					log.info("Users found with findAll():");
					log.info("-------------------------------");
					for (User usr : repository.findAll()) {
						log.info(usr.toString());
					}
					log.info("");
				}

				// fetch user by login
				log.info("User found with findByUsername('pierrel@dotloop.com'):");
				log.info("--------------------------------------------");
				for (User pl : repository.findByUsername("pierrel@dotloop.com")) {
					log.info(pl.toString());
				}
			};
		}

}
