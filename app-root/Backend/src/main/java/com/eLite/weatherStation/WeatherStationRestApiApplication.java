package com.eLite.weatherStation;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import springfox.documentation.swagger2.annotations.EnableSwagger2;


@SpringBootApplication(scanBasePackages = {"controllers", "config" })
@EnableJpaRepositories("repositories")
@EntityScan(basePackages = {"models"})
@EnableSwagger2
public class WeatherStationRestApiApplication extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(WeatherStationRestApiApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(WeatherStationRestApiApplication.class);
	}
}
