# Estructura-conserva-formato-Word-to-Canva
# WordToCanva Extensión
# WordToCanva Extensión

![WordToCanva Logo](assets/images/logo.png)

Extensión para transferir contenido de Microsoft Word a Canva conservando el formato básico, viñetas y listas.

## 🚀 Características

- ✅ Conserva formato básico (negritas, cursivas, subrayados)
- ✅ Mantiene viñetas y listas numeradas
- ✅ Transferencia rápida y sencilla
- ✅ Funciona con la versión web de Canva
- ✅ Sin instalación de software adicional

## 📦 Versión Gratuita

La versión gratuita incluye:
- Conservación de formato básico
- Soporte para viñetas simples
- Transferencia de texto con estilos básicos

## 💼 Licencia Comercial Disponible

¿Necesitas más funcionalidades? La **licencia comercial** incluye:

- ✅ Conservación de listas numeradas y con letras (A.B.C.)
- ✅ Soporte para tablas y formatos complejos
- ✅ Prioridad en soporte técnico
- ✅ Actualizaciones permanentes
- ✅ Uso comercial permitido

**Precio: $19.99** - [Más información sobre la licencia comercial](docs/licencia-comercial.md)

## 🛠️ Instalación y Uso

### 1. Configurar la macro de Word
1. Descarga el archivo `WordToCanva.bas` desde la carpeta `src/word-macro/`
2. Abre Word y presiona `ALT + F11` para abrir el editor de VBA
3. Importa el archivo .bas
4. Ejecuta la macro para exportar tu contenido

### 2. Configurar el bookmarklet de Canva
1. Arrastra el siguiente enlace a tu barra de marcadores: [WordToCanva Transfer]
2. O copia el código de `bookmarklet.js` y crea un marcador manualmente

### 3. Transferir contenido
1. Ejecuta la macro en Word
2. Abre tu diseño en Canva
3. Haz clic en el bookmarklet
4. Pega el contenido cuando se te solicite

## 📝 Ejemplo de uso

```html
<!-- Contenido exportado desde Word -->
<h1>Título principal</h1>
<p>Párrafo con <strong>texto en negrita</strong> y <em>texto en cursiva</em>.</p>
<ul>
  <li>Elemento de lista 1</li>
  <li>Elemento de lista 2</li>
</ul>
