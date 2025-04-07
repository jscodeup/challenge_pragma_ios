# challenge_pragma_ios

Aplicación iOS desarrollada como parte de un challenge técnico. Permite listar razas de gatos y ver información detallada de cada una, consumiendo datos desde:  https://api.thecatapi.com/v1/breeds

---

## 🛠 Tecnologías utilizadas

- **Lenguaje**: Swift
- **Framework**: UIKit
- **Arquitectura**: MVVM + Clean Architecture
- **Networking**: URLSession
- **Caché de imágenes**: Kingfisher (https://github.com/onevcat/Kingfisher)
- **Tests**: XCTest + XCTest UI
- **Layout**: Auto Layout + UIStackView
- **Dependencias**: ninguna externa

---

## 📲 Funcionalidades

- Listado de razas con nombre, país e inteligencia
- Pantalla de detalle con:
  - Imagen ampliada
  - Descripción
  - País de origen
  - Inteligencia
  - Adaptabilidad
  - Esperanza de vida
- Carga de datos desde API remota (`https://api.thecatapi.com/v1/breeds`)
- Header de autenticación `x-api-key` incluido
- Manejo de errores básicos

---

## 🧪 Tests

- **Unit Tests**
  - ViewModels
- **UI Tests**
  - Navegación desde lista a pantalla de detalle
  - Validación de datos visibles

---


## 🚀 Cómo correr el proyecto

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/challenge_pragma_ios.git
   ```
2. Abre el archivo `.xcodeproj` o `.xcworkspace` en Xcode
3. Ejecuta el proyecto con `⌘ + R`
4. Corre los tests con `⌘ + U`

---


## 📬 Contacto

Desarrollado por **Julián Salazar**  
[hjsalazar9@gmail.com]
