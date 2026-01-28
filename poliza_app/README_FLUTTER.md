# Sistema de Pólizas - Frontend Flutter

Frontend en Flutter con arquitectura MVC para el sistema de gestión de pólizas de seguros de automóviles.

## 📁 Estructura del Proyecto (MVC)

```
lib/
├── main.dart                      # Punto de entrada
├── models/                        # Modelos de datos
│   └── poliza_model.dart
├── views/                         # Vistas (UI)
│   ├── home_view.dart
│   ├── crear_poliza_view.dart
│   └── buscar_poliza_view.dart
├── controllers/                   # Controladores (lógica)
│   └── poliza_controller.dart
└── services/                      # Servicios (API)
    └── api_service.dart
```

## 🚀 Cómo ejecutar el proyecto

### 1. Iniciar el Backend (Spring Boot)
```bash
cd C:\Users\Gabo\Downloads\bdd_dto\bdd_dto
./mvnw spring-boot:run
```
El backend estará en: `http://localhost:9090/bdd_dto`

### 2. Ejecutar el Frontend (Flutter)

#### Para Windows:
```bash
cd C:\Users\Gabo\Downloads\bdd_dto\poliza_app
flutter run -d windows
```

#### Para Web:
```bash
cd C:\Users\Gabo\Downloads\bdd_dto\poliza_app
flutter run -d chrome
```

#### Para Android (con emulador/dispositivo):
```bash
cd C:\Users\Gabo\Downloads\bdd_dto\poliza_app
flutter run
```

## 📱 Características de la Interfaz

### Pantalla Principal (Home)
- Botón para crear póliza
- Botón para buscar póliza

### Crear Póliza
- ✅ Campo de texto: Propietario
- ✅ Campo de texto: Valor del seguro
- ✅ RadioButtons: Modelo de auto (A, B, C)
- ✅ RadioButtons: Rango de edad (18-23, 23-55, 55+)
- ✅ Campo numérico: Número de accidentes
- ✅ Checkbox: Términos y condiciones
- Botón: CREAR PÓLIZA

### Buscar Póliza
- Campo de búsqueda por nombre de propietario
- Muestra información completa de la póliza encontrada
- Cálculo del costo total del seguro

## 🎨 Diseño

- Color principal: **Teal** (Verde azulado)
- Diseño moderno con Material Design 3
- Interfaz limpia y fácil de usar
- Responsive para diferentes tamaños de pantalla

## 🔧 Componentes Utilizados

- **RadioButton**: Selección de modelo (A, B, C)
- **RadioGroup**: Selección de rango de edad
- **Checkbox**: Aceptación de términos
- **TextField**: Campos de entrada de texto
- **ElevatedButton**: Botones de acción
- **Card**: Tarjetas para mostrar información

## 📦 Dependencias

- `http: ^1.6.0` - Para llamadas HTTP al backend
- `provider: ^6.1.5` - Para gestión de estado (MVC Controller)

## 🌐 Configuración del Backend

El frontend está configurado para conectarse a:
```
http://localhost:9090/bdd_dto
```

Si tu backend está en otra URL, edita el archivo:
`lib/services/api_service.dart`

```dart
static const String baseUrl = 'http://TU_URL_AQUI';
```

## 📝 Endpoints que consume

- `POST /api/poliza` - Crear póliza completa
- `GET /api/poliza/usuario?nombre={nombre}` - Buscar póliza por nombre

## ✅ Checklist de Features

- [x] Arquitectura MVC
- [x] RadioButtons para modelo (A, B, C)
- [x] RadioButtons para rangos de edad
- [x] Checkbox para términos
- [x] Validación de formularios
- [x] Integración con backend
- [x] Pantalla de búsqueda
- [x] Manejo de errores
- [x] Loading states
- [x] Diseño responsive

## 🐛 Solución de Problemas

### Error de conexión
Si no se puede conectar al backend:
1. Verifica que el backend esté corriendo en `http://localhost:9090`
2. Si usas un emulador Android, usa `http://10.0.2.2:9090/bdd_dto` en lugar de localhost
3. Verifica que no haya un firewall bloqueando la conexión

### Hot reload no funciona
```bash
# Reinicia la app con:
r (en la terminal de Flutter)

# O reinicia completamente:
R (en la terminal de Flutter)
```

## 👨‍💻 Desarrollo

### Agregar nuevas pantallas
1. Crear archivo en `lib/views/`
2. Importar en el archivo que lo necesite
3. Usar `Navigator.push()` para navegar

### Modificar la lógica
- Edita `lib/controllers/poliza_controller.dart`
- Usa `notifyListeners()` para actualizar la UI

### Agregar nuevos modelos
- Crea archivos en `lib/models/`
- Define las clases con `toJson()` y `fromJson()`

---

**Desarrollado con Flutter 🚀**
