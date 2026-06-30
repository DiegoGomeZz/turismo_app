# TuriSalta Frontend

Aplicación móvil desarrollada con Flutter para asistir a turistas en la búsqueda de atracciones, eventos y lugares de interés en la provincia de Salta.

## Tecnologías

- Flutter
- Dart
- Provider
- HTTP
- Google Maps Flutter
- Cached Network Image

---

## Requisitos

- Flutter SDK 3.11.5 o superior
- Dart SDK 3.11.5 o superior
- Android Studio o VS Code
- Android SDK

Verificar la instalación:

```bash
flutter doctor
```

---

## Instalación

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
cd turismo_app
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Ejecutar la aplicación

```bash
flutter run
```

Para listar los dispositivos disponibles:

```bash
flutter devices
```

---

## Generar APK

Modo release:

```bash
flutter build apk --release
```

El APK generado se encuentra en:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## Estructura del proyecto

```
lib/
│
├── core/
│   ├── models/
│   ├── services/
│   └── widgets/
│
├── features/
│   ├── home/
│   ├── map/
│   ├── profile/
│   ├── search/
│   └── provisorio/
│
└── main.dart
```

### Descripción de módulos

- **core/**: modelos, servicios compartidos y widgets reutilizables.
- **home/**: pantalla principal, detalle de atracciones y creación de eventos.
- **map/**: integración con Google Maps y administración de lugares.
- **profile/**: perfil del usuario.
- **search/**: búsqueda de atracciones.
- **provisorio/**: pantallas temporales utilizadas durante el desarrollo.

---

## Dependencias principales

- provider
- http
- google_maps_flutter
- cached_network_image
- shimmer

---

## Assets

Las imágenes de la aplicación se encuentran en:

```
assets/images/
```

---

## Backend

Repositorio: https://github.com/quinjoa7/turismo-app-back/tree/main

La aplicación consume la API REST del proyecto TuriSalta Backend.

Principales módulos utilizados:

- Authentication
- Users
- Attractions
- Favorites
- Reviews

---

## Integrantes

- Camila Cisnero
- Joaquín Rojas
- Homero Tarifa
- Diego Gómez
