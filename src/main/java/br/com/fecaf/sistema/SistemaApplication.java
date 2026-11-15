package br.com.fecaf.sistema;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SistemaApplication {

	public static void main(String[] args) {
		SpringApplication.run(SistemaApplication.class, args);
	}


	@Bean 
	CommandLineRunner initialization() {
		return args -> {
			System.out.println("Sistema iniciado com sucesso!");
		};
	}
}
