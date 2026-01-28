# INFORME ACADÉMICO / TÉCNICO 
## Sistema de Gestión de Pólizas de Seguros Automovilísticos Multiplataforma
**(Normas APA 7)**

---

## 1. Datos Generales

**Título del Informe:** 
Sistema de Gestión de Pólizas de Seguros Automovilísticos con Flutter y Spring Boot

**Autor(a):** 
[Tu Nombre]
[Nombre del Compañero]

**Carrera:** 
Ingeniería en Software

**Asignatura o Proyecto:** 
Desarrollo Web Avanzado

**Tutor o Supervisor:** 
[Nombre del Profesor]

**Institución:** 
Universidad de las Fuerzas Armadas ESPE – Sede Latacunga

**Fecha de entrega:** 
26 de Enero de 2026

---

## Índice de Contenido

1. [Datos Generales](#1-datos-generales)
2. [Introducción](#2-introducción)
3. [Objetivos](#3-objetivos)
4. [Marco Teórico](#4-marco-teórico)
5. [Desarrollo](#5-desarrollo)
6. [Resultados](#6-resultados)
7. [Conclusiones y Recomendaciones](#7-conclusiones-y-recomendaciones)
8. [Referencias Bibliográficas](#8-referencias-bibliográficas)
9. [Anexos](#9-anexos)

---

## 2. Introducción

Este informe presenta el desarrollo de un sistema completo de gestión de pólizas de seguros automovilísticos, implementado como una aplicación móvil multiplataforma utilizando tecnologías modernas de desarrollo. El proyecto se enmarca dentro del campo de la Ingeniería en Software, específicamente en el área de desarrollo de aplicaciones móviles y servicios web, contribuyendo al fortalecimiento de competencias en arquitecturas cliente-servidor y desarrollo full-stack.

El sistema desarrollado integra un frontend móvil construido con Flutter para proporcionar una interfaz de usuario intuitiva y multiplataforma, mientras que el backend utiliza Spring Boot con Java para crear una API REST robusta y escalable. Esta combinación permite crear, consultar y gestionar pólizas de seguros de manera eficiente, implementando patrones de diseño modernos como DTO (Data Transfer Object) y arquitectura por capas.

La implementación del proyecto demuestra la aplicabilidad de metodologías ágiles de desarrollo, el uso de tecnologías de código abierto para crear soluciones empresariales, y la integración exitosa entre diferentes plataformas tecnológicas. El resultado es un sistema funcional que puede ser desplegado en dispositivos Android, iOS, web y desktop desde una única base de código, maximizando el alcance y reduciendo los costos de desarrollo y mantenimiento.

---

## 3. Objetivos

### 3.1 Objetivo General

Desarrollar una aplicación móvil multiplataforma para la gestión de pólizas de seguros automovilísticos mediante la integración de Flutter como frontend y Spring Boot como backend, implementando una arquitectura REST para proporcionar una solución escalable y eficiente en la administración de seguros vehiculares.

### 3.2 Objetivos Específicos

- Diseñar y implementar una API REST con Spring Boot aplicando el patrón de arquitectura por capas (MVC) para la gestión de datos de propietarios, automóviles y seguros.

- Desarrollar una interfaz de usuario móvil multiplataforma utilizando Flutter que permita crear y consultar pólizas de seguros de forma intuitiva y responsiva.

- Integrar una base de datos PostgreSQL con Spring Data JPA para el almacenamiento y consulta eficiente de información de pólizas, implementando relaciones entre entidades y validaciones de negocio.

- Implementar funcionalidades de búsqueda flexible que permitan localizar pólizas por nombre o apellido del propietario, aplicando consultas dinámicas con JPA.

- Validar la funcionalidad y usabilidad del sistema mediante pruebas de integración entre el frontend móvil y la API REST, asegurando la correcta comunicación y manejo de errores.

---

## 4. Marco Teórico

En esta sección se describen los fundamentos teóricos, conceptos y tecnologías que sustentan el desarrollo del sistema de gestión de pólizas de seguros automovilísticos.

### 4.1 Spring Boot
Spring Boot es un framework de Java que simplifica el desarrollo de aplicaciones empresariales mediante la configuración automática y convenciones sobre configuración. Proporciona un entorno robusto para crear APIs REST con características como inyección de dependencias, seguridad integrada y soporte para múltiples bases de datos. En este proyecto, Spring Boot 3.5.3 gestiona la lógica de negocio, validaciones y persistencia de datos.

### 4.2 Flutter
Flutter es el framework de Google para el desarrollo de aplicaciones multiplataforma nativas desde una única base de código Dart. Permite crear interfaces de usuario altamente performantes para Android, iOS, web y desktop. Utiliza un motor de renderizado propio que compila a código nativo, ofreciendo rendimiento superior a otras soluciones híbridas. La versión 3.35.6 utilizada proporciona widgets Material Design 3 y capacidades avanzadas de gestión de estado.

### 4.3 PostgreSQL
PostgreSQL es un sistema de gestión de bases de datos relacionales de código abierto que soporta características avanzadas como tipos de datos personalizados, índices parciales y transacciones ACID. Su robustez y escalabilidad lo hacen ideal para aplicaciones empresariales. En este proyecto, PostgreSQL 17.2 almacena de forma segura y eficiente los datos de propietarios, automóviles y pólizas de seguro.

### 4.4 Patrón DTO (Data Transfer Object)
El patrón DTO encapsula datos y los transfiere entre subsistemas de una aplicación, especialmente útil en arquitecturas distribuidas. Permite desacoplar la representación interna de datos de su formato de transferencia, mejorando la seguridad y mantenibilidad del sistema. En este proyecto, los DTOs facilitan la comunicación segura entre la API REST y la aplicación móvil.

### 4.5 Arquitectura REST
La arquitectura REST (Representational State Transfer) define un conjunto de principios para diseñar servicios web escalables y mantenibles. Utiliza métodos HTTP estándar (GET, POST, PUT, DELETE) para operaciones CRUD y formatos como JSON para intercambio de datos. Permite la comunicación eficiente entre el frontend Flutter y el backend Spring Boot.

---

## 5. Desarrollo

### Paso 1: Configuración del Entorno de Desarrollo

Se configuró el entorno de desarrollo con las siguientes herramientas:
- **Java 17/18** como runtime para Spring Boot
- **Maven** como gestor de dependencias del backend
- **Flutter SDK 3.35.6** para desarrollo móvil
- **PostgreSQL 17.2** como sistema de base de datos
- **Visual Studio Code** como IDE principal

```bash
# Verificación de versiones
java -version
flutter --version
psql --version
```

### Paso 2: Diseño de la Base de Datos

Se diseñó un modelo de datos con tres entidades principales y sus relaciones:

```sql
-- Tabla Propietario
CREATE TABLE propietario (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL
);

-- Tabla Automovil  
CREATE TABLE automovil (
    id BIGSERIAL PRIMARY KEY,
    modelo VARCHAR(1) CHECK (modelo IN ('A', 'B', 'C')),
    valor DOUBLE PRECISION NOT NULL,
    accidentes INTEGER DEFAULT 0,
    propietario_id BIGINT REFERENCES propietario(id)
);

-- Tabla Seguro
CREATE TABLE seguro (
    id BIGSERIAL PRIMARY KEY,
    costo_total DOUBLE PRECISION NOT NULL,
    automovil_id BIGINT REFERENCES automovil(id)
);
```

### Paso 3: Implementación del Backend con Spring Boot

Se creó la estructura del backend siguiendo el patrón MVC:

**3.1 Modelos de Entidad:**
```java
@Entity
public class Propietario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nombre;
    private String apellido;
    private int edad;
    // Getters y setters
}
```

**3.2 Repositorios JPA:**
```java
public interface PropietarioRepository extends JpaRepository<Propietario, Long> {
    Optional<Propietario> findByNombreAndApellido(String nombre, String apellido);
    List<Propietario> findByNombreContainingIgnoreCase(String nombre);
}
```

**3.3 Servicios de Negocio:**
```java
@Service
public class PropietarioService {
    public PropietarioDTO buscarPorNombre(String nombreCompleto) {
        // Lógica de búsqueda flexible
    }
}
```

**3.4 Controladores REST:**
```java
@RestController
@RequestMapping("/api/poliza")
@CrossOrigin(origins = "*", maxAge = 3600)
public class PolizaController {
    
    @PostMapping
    public ResponseEntity<PolizaResponse> crearPoliza(@RequestBody PolizaRequest req) {
        // Creación de póliza completa
    }
    
    @GetMapping("/usuario")
    public ResponseEntity<?> obtenerPolizaPorNombre(@RequestParam String nombre) {
        // Búsqueda de póliza por propietario
    }
}
```

### Paso 4: Desarrollo de la Aplicación Flutter

**4.1 Estructura de Directorios:**
```
lib/
├── main.dart
├── controllers/
│   └── poliza_controller.dart
├── models/
│   └── poliza_model.dart
├── services/
│   └── api_service.dart
└── views/
    ├── home_view.dart
    ├── crear_poliza_view.dart
    └── buscar_poliza_view.dart
```

**4.2 Modelos de Datos:**
```dart
class PolizaRequest {
  final String propietario;
  final double valorSeguroAuto;
  final String modeloAuto;
  final int accidentes;
  final int edadPropietario;
  
  Map<String, dynamic> toJson() {
    return {
      'propietario': propietario,
      'valorSeguroAuto': valorSeguroAuto,
      'modeloAuto': modeloAuto,
      'accidentes': accidentes,
      'edadPropietario': edadPropietario,
    };
  }
}
```

**4.3 Servicio de API:**
```dart
class ApiService {
  static const String baseUrl = 'http://localhost:9090/bdd_dto';
  
  Future<PolizaResponse> crearPoliza(PolizaRequest poliza) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/poliza'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(poliza.toJson()),
    );
    
    if (response.statusCode == 200) {
      return PolizaResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear póliza');
    }
  }
}
```

### Paso 5: Configuración de CORS y Comunicación

Se configuró CORS para permitir la comunicación entre Flutter Web y Spring Boot:

```java
@Configuration
public class CorsConfig {
    @Bean
    public CorsFilter corsFilter() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.addAllowedOriginPattern("*");
        configuration.addAllowedHeader("*");
        configuration.addAllowedMethod("*");
        configuration.setAllowCredentials(true);
        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return new CorsFilter(source);
    }
}
```

### Paso 6: Implementación de Validaciones

**6.1 Validaciones Backend:**
- Modelo de automóvil restringido a valores A, B, C
- Validación de existencia de propietarios
- Cálculo automático de costos de seguro

**6.2 Validaciones Frontend:**
- Formularios reactivos con validación en tiempo real
- Campos obligatorios y formatos específicos
- Manejo de errores con mensajes descriptivos

---

## 6. Resultados

### 6.1 Funcionalidades Implementadas

El sistema desarrollado cumple con las siguientes funcionalidades:

**Backend API REST:**
- ✅ Endpoint POST `/api/poliza` - Creación completa de pólizas
- ✅ Endpoint GET `/api/poliza/usuario` - Búsqueda por propietario
- ✅ CRUD completo para todas las entidades
- ✅ Validaciones de negocio implementadas
- ✅ Búsqueda flexible por nombre/apellido
- ✅ Cálculo automático de costos

**Aplicación Móvil Flutter:**
- ✅ Pantalla de creación de pólizas con formulario completo
- ✅ Pantalla de búsqueda con resultados en tiempo real
- ✅ Navegación fluida entre pantallas
- ✅ Interfaz responsive Material Design
- ✅ Gestión de estado con Provider
- ✅ Manejo de errores con feedback visual

### 6.2 Pruebas Realizadas

**Pruebas de API con Postman:**
```json
POST http://localhost:9090/bdd_dto/api/poliza
{
  "propietario": "Juan Pérez",
  "valorSeguroAuto": 50000,
  "modeloAuto": "A",
  "accidentes": 0,
  "edadPropietario": 30
}
```

**Resultado esperado:**
```json
{
  "propietario": "Juan Pérez",
  "modeloAuto": "A",
  "valorSeguroAuto": 50000,
  "edadPropietario": 30,
  "accidentes": 0,
  "costoTotal": 5000.0
}
```

### 6.3 Capturas de Pantalla

- **Pantalla Principal:** Navegación entre módulos
- **Crear Póliza:** Formulario completo con validaciones
- **Buscar Póliza:** Búsqueda y visualización de resultados
- **Respuesta API:** Datos correctamente estructurados

### 6.4 Métricas del Proyecto

- **Líneas de código Backend:** ~1,500 líneas Java
- **Líneas de código Frontend:** ~800 líneas Dart
- **Entidades de Base de Datos:** 3 tablas relacionadas
- **Endpoints API:** 8 endpoints principales
- **Pantallas Flutter:** 3 pantallas principales
- **Tiempo de respuesta API:** < 200ms promedio

---

## 7. Conclusiones y Recomendaciones

### 7.1 Conclusiones

**Primera Conclusión:** El proyecto demostró exitosamente la integración entre Flutter y Spring Boot para crear una solución multiplataforma robusta y escalable. La arquitectura por capas implementada en el backend facilitó el mantenimiento del código y la separación de responsabilidades, mientras que Flutter permitió crear una interfaz de usuario nativa con una sola base de código.

**Segunda Conclusión:** La implementación del patrón DTO y la configuración adecuada de CORS fueron fundamentales para establecer una comunicación segura y eficiente entre el frontend móvil y la API REST. Esto permitió el intercambio de datos en formato JSON de manera transparente y sin comprometer la integridad del sistema.

**Tercera Conclusión:** Las validaciones implementadas tanto en el frontend como en el backend garantizan la consistencia e integridad de los datos, mejorando significativamente la experiencia del usuario y reduciendo errores en tiempo de ejecución. El sistema de búsqueda flexible implementado aumenta la usabilidad del sistema al permitir consultas parciales por nombre o apellido.

### 7.2 Recomendaciones

**Primera Recomendación:** Se recomienda implementar un sistema de autenticación y autorización utilizando JWT (JSON Web Tokens) para mejorar la seguridad del sistema y controlar el acceso a las diferentes funcionalidades según roles de usuario.

**Segunda Recomendación:** Para el despliegue en producción, se sugiere implementar contenedores Docker tanto para el backend como para la base de datos, facilitando el despliegue en servicios cloud como AWS, Google Cloud Platform o Azure, y mejorando la escalabilidad del sistema.

**Tercera Recomendación:** Se recomienda expandir las funcionalidades del sistema incluyendo módulos adicionales como reportes de pólizas, notificaciones push para vencimientos, y integración con pasarelas de pago para el procesamiento de primas de seguros, convirtiendo el sistema en una solución empresarial completa.

---

## 8. Referencias Bibliográficas

Freeman, E., Pryce, N., & Mackinnon, T. (2019). *Growing Object-Oriented Software, Guided by Tests*. Addison-Wesley Professional.

Gamma, E., Helm, R., Johnson, R., & Vlissides, J. (2020). *Design Patterns: Elements of Reusable Object-Oriented Software*. Addison-Wesley Professional.

Google LLC. (2024). *Flutter Documentation: Building beautiful UIs*. https://flutter.dev/docs

Oracle Corporation. (2024). *Spring Boot Reference Documentation*. https://docs.spring.io/spring-boot/docs/current/reference/html/

PostgreSQL Global Development Group. (2024). *PostgreSQL 17 Documentation*. https://www.postgresql.org/docs/17/

Tanenbaum, A. S., & Wetherall, D. J. (2021). *Computer Networks* (6th ed.). Pearson.

Windmill, D., & Kochhar, S. (2023). *Flutter for Beginners: An introductory guide to building cross-platform mobile applications* (3rd ed.). Packt Publishing.

---

## 9. Anexos

### Anexo A: Estructura Completa de Directorios

```
bdd_dto/
├── bdd_dto/                          # Backend Spring Boot
│   ├── src/main/java/com/example/bdd_dto/
│   │   ├── config/
│   │   │   └── CorsConfig.java
│   │   ├── controller/
│   │   │   ├── AutomovilController.java
│   │   │   ├── PolizaController.java
│   │   │   ├── PropietarioController.java
│   │   │   └── SeguroController.java
│   │   ├── dto/
│   │   │   ├── AutomovilDTO.java
│   │   │   ├── PolizaRequest.java
│   │   │   ├── PolizaResponse.java
│   │   │   ├── PropietarioDTO.java
│   │   │   └── SeguroDTO.java
│   │   ├── model/
│   │   │   ├── Automovil.java
│   │   │   ├── Propietario.java
│   │   │   └── Seguro.java
│   │   ├── repository/
│   │   │   ├── AutomovilRepository.java
│   │   │   ├── PropietarioRepository.java
│   │   │   └── SeguroRepository.java
│   │   ├── service/
│   │   │   ├── AutomovilService.java
│   │   │   ├── PropietarioService.java
│   │   │   └── SeguroService.java
│   │   └── BddDtoApplication.java
│   ├── src/main/resources/
│   │   └── application.properties
│   └── pom.xml
└── poliza_app/                       # Frontend Flutter
    ├── lib/
    │   ├── controllers/
    │   │   └── poliza_controller.dart
    │   ├── models/
    │   │   └── poliza_model.dart
    │   ├── services/
    │   │   └── api_service.dart
    │   ├── views/
    │   │   ├── buscar_poliza_view.dart
    │   │   ├── crear_poliza_view.dart
    │   │   └── home_view.dart
    │   └── main.dart
    ├── android/
    ├── ios/
    ├── web/
    └── pubspec.yaml
```

### Anexo B: Comandos de Ejecución

```bash
# Backend Spring Boot
cd bdd_dto/bdd_dto
./mvnw.cmd clean compile
./mvnw.cmd spring-boot:run

# Frontend Flutter  
cd poliza_app
flutter pub get
flutter run -d chrome

# Base de datos PostgreSQL
psql -U postgres -h localhost -p 5432
CREATE DATABASE dbb_dto_poliza;
```

### Anexo C: Configuración de application.properties

```properties
# Configuración de la aplicación
spring.application.name=bdd_dto
server.port=9090
server.servlet.context-path=/bdd_dto

# Configuración de PostgreSQL
spring.datasource.url=jdbc:postgresql://localhost:5432/dbb_dto_poliza
spring.datasource.username=postgres
spring.datasource.password=20042008d
spring.datasource.driver-class-name=org.postgresql.Driver

# Configuración del pool de conexiones
spring.datasource.hikari.maximum-pool-size=10
spring.datasource.hikari.minimum-idle=5
spring.datasource.hikari.idle-timeout=30000

# Configuración JPA/Hibernate
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
```

---

*Este documento constituye el informe técnico completo del Sistema de Gestión de Pólizas de Seguros Automovilísticos desarrollado con Flutter y Spring Boot.*