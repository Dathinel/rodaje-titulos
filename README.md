<p align="center">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://raw.githubusercontent.com/Dathinel/rodaje/main/assets/marca/rodaje.svg" alt="Logotipo de Rodaje" width="104"></a>
</p>

<h1 align="center">rodaje-titulos</h1>

<p align="center">
  Complemento opcional para <a href="https://github.com/Dathinel/rodaje">Rodaje</a>: 15 estilos de texto propios, con subtítulos y karaoke, hechos solo con datos (fuente, colores, borde, sombra, fondo y curvas de entrada y salida).
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/licencia-CC0_1.0-E8833A?style=flat-square&labelColor=1D1D1D" alt="Licencia CC0 1.0"></a>
  <a href="https://github.com/Dathinel/rodaje-titulos/releases/latest"><img src="https://img.shields.io/github/v/release/Dathinel/rodaje-titulos?style=flat-square&labelColor=1D1D1D&color=E8833A&label=versi%C3%B3n" alt="Última versión"></a>
  <img src="https://img.shields.io/badge/contenido-15_estilos-E8833A?style=flat-square&labelColor=1D1D1D" alt="Contenido: 15 estilos">
  <img src="https://img.shields.io/badge/formato-.paquete-E8833A?style=flat-square&labelColor=1D1D1D" alt="Formato .paquete">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://img.shields.io/badge/para-Rodaje-E8833A?style=flat-square&labelColor=1D1D1D" alt="Para Rodaje"></a>
</p>

| Estilo | Fuente | Cómo es |
|---|---|---|
| Título grande | Inter 800 | Blanco con sombra suave; entra creciendo un poco |
| Tercio inferior | Montserrat 600 | Banda oscura a la izquierda; entra deslizándose |
| Cita | Lora cursiva | Crema, interlineado amplio, fundido lento |
| Rótulo condensado | Oswald 600 | Espaciado, borde fino; sube al entrar |
| Neón | Montserrat 700 | Halo cian que parpadea al encenderse |
| Manuscrito | Caveat 600 | Cálido, entra con un pequeño giro |
| Máquina de escribir | JetBrains Mono | Caja negra, aparece en dos golpes |
| Redondeado | Nunito 800 | Píldora coral con rebote |
| Impacto | Anton | Amarillo con borde y sombra dura; entra desde grande |
| Minimal | Inter 300 | Fino y muy espaciado |
| Etiqueta | Inter 700 | Pastilla naranja para un dato |
| Subtítulos | Atkinson Hyperlegible Next | Borde y sombra, fundido de 0,12 s |
| Subtítulos en caja | Noto Sans | Caja semitransparente, sin animación |
| Karaoke pop | Montserrat 800 | La palabra que suena, en amarillo |
| Karaoke suave | Nunito 800 | Caja oscura; la palabra que suena, en turquesa |

**Necesita [rodaje-fuentes](https://github.com/Dathinel/rodaje-fuentes).** Cada estilo nombra su familia y su elemento (`rodaje-fuentes@1.0.0/inter`); sin ese paquete se ve con su respaldo de Windows (Segoe UI, Georgia, Consolas, Impact…). Los de karaoke llevan además `highlight.color`, el color de la palabra que se está diciendo; una versión de Rodaje que no lo conoce lo ignora.

## Instalar en Rodaje

En Rodaje, Complementos → Instalar lo baja, comprueba su firma y lo instala; instala también rodaje-fuentes. A mano: descarga `rodaje-titulos-<versión>.paquete` de las [releases](https://github.com/Dathinel/rodaje-titulos/releases) y, en Rodaje, usa «Instalar desde archivo…» en Complementos o suéltalo sobre la biblioteca. Aparecen en Texto. Más detalles en la [guía de complementos](https://github.com/Dathinel/rodaje/blob/main/docs/guia/complementos.md).

## Construir el paquete

```
powershell -NoProfile -ExecutionPolicy Bypass -File empaquetar.ps1
```

Solo hace falta Windows PowerShell 5.1. Genera los estilos y deja `dist\rodaje-titulos-<versión>.paquete` con orden y fecha fijos: las mismas fuentes dan el mismo archivo byte a byte.

| Archivo | Qué es |
|---|---|
| `paquete.json` | Manifiesto: 15 `text-style` |
| `generar.ps1` | Los estilos; escribe `estilos/*.json` (`rodaje.textstyle` v1) |
| `empaquetar.ps1` | Arma el `.paquete` |

## Licencia

CC0 1.0 (dominio público), ver `LICENSE`. Las fuentes no van aquí: son de sus autores y llegan con rodaje-fuentes bajo la OFL 1.1. El logotipo de Rodaje es marca de su autor y no forma parte de este contenido ([TRADEMARK.md](https://github.com/Dathinel/rodaje/blob/main/TRADEMARK.md)).
