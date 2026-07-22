# Sistema Responsive - Documentación

## Puntos de Quiebre (Breakpoints)

```
Desktop Large: ≥ 1920px  (Ancho máximo del contenido)
Desktop:       ≥ 1200px  (Diseño desktop completo)
Tablet:        700px - 1199px (Diseño tablet)
Mobile:        400px - 699px   (Diseño móvil)
Small:         < 400px         (Mínimo)
```

## Cambios por Dispositivo

### 📱 DESKTOP (≥ 1200px)
**Sidebar:**
- Ancho: 200px
- Muestra etiquetas completas con iconos
- Navegación vertical

**Header:**
- Altura: 100px
- Muestra: "BIENVENDIDO" + Buscador completo + Notificaciones + Perfil
- Padding: 20px

**Home Screen:**
- Proyección: 450px de ancho (se reduce proporcionalmente hasta 1200px)
- Piscinas: 220px de ancho x 400px alto
- Estadística y Diversidad: en fila inferior (2:1 ratio)

---

### 📱 TABLET (700px - 1199px)
**Sidebar:**
- Ancho: 80px (solo iconos)
- Sin scroll horizontal
- Logo reducido a 60px
- Elementos compactos

**Header:**
- Altura: 80px
- Muestra: "BIENVENIDO" (reducido) + Buscador compacto + Iconos
- Padding: 15px

**Home Screen:**
- Layout en columnas flexibles
- Proyección y Piscinas en primera fila
- Estadística y Diversidad en segunda fila
- Tamaños reducidos dinámicamente

---

### 📱 MOBILE (400px - 699px)
**Sidebar:**
- Se convierte en Bottom Navigation Bar (parte inferior)
- Solo iconos (45x45px)
- Horizontal, sin scroll
- Con scroll horizontal si no caben todos los iconos

**Header:**
- Altura: 70px
- Muestra: Solo search icon + Notificaciones + Perfil (todos iconos)
- Padding: 10px
- Texto "BIENVENIDO" oculto

**Home Screen:**
- Layout en columna vertical (ScrollView)
- Proyección: ancho completo
- Piscinas: 110px ancho x 60-80px alto
- Estadística y Diversidad: width 100%

---

### 📱 SMALL (< 400px)
**Layout similar a Mobile pero:**
- Tamaños aún más reducidos
- Piscinas: 90px x 60px
- Todo ajustado al espacio mínimo

---

## Cómo Usar ResponsiveSize

```dart
// Verificar tipo de dispositivo
if (ResponsiveSize.isDesktop(context)) { }
if (ResponsiveSize.isMedium(context)) { }
if (ResponsiveSize.small(context)) { }
if (ResponsiveSize.isSmall(context)) { }

// Obtener tipo de dispositivo
DeviceType type = ResponsiveSize.getDeviceType(MediaQuery.of(context).size.width);

// Obtener tamaños específicos
double sidebarWidth = ResponsiveSize.getSidebarWidth(context);
double headerHeight = ResponsiveSize.getHeaderHeight(context);
double piscinaWidth = ResponsiveSize.getPiscinaWidth(context);
EdgeInsets padding = ResponsiveSize.getHeaderPadding(context);
```

## Componentes Modificados

1. **lib/core/responsive.dart** - Sistema central de responsive
2. **lib/presentation/layout/layout.dart** - Layout principal adaptable
3. **lib/presentation/layout/sidebar/sidebar.dart** - Sidebar con 3 versiones
4. **lib/presentation/components/header.dart** - Header responsive
5. **lib/presentation/screens/home_screen.dart** - Home screen con 3 layouts

## Escalabilidad Dinámico

En **Desktop**, el contenido se reduce **proporcionalmente** conforme disminuye el ancho hasta llegar a **1200px**:
- Proyección: se reduce en proporción (450px en 1920 → menor en 1200)
- Widgets mantienen proporción aspect ratio
- Sin saltos abruptos entre breakpoints

## Testing Recomendado

Para probar los diferentes layouts en VS Code:
1. Redimensionar la ventana del navegador/emulador
2. O usar DevTools de Flutter para cambiar el screen size
3. Verificar que el layout se adapte suavemente en cada breakpoint
