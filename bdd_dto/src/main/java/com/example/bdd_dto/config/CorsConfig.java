package com.example.bdd_dto.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration configuration = new CorsConfiguration();
        
        // Permitir requests desde Flutter Web (localhost)
        configuration.addAllowedOriginPattern("*");
        
        // Permitir todos los headers
        configuration.addAllowedHeader("*");
        
        // Permitir todos los métodos HTTP
        configuration.addAllowedMethod("*");
        
        // Permitir credenciales
        configuration.setAllowCredentials(true);
        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        
        return new CorsFilter(source);
    }
}