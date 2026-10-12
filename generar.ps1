# Genera los estilos de rodaje-titulos (rodaje.textstyle v1) en <Destino>\estilos\, deterministas: la misma salida
# byte a byte en cualquier equipo. Lo llama empaquetar.ps1; sin -Destino escribe en la carpeta del script.
# Cada estilo es una tabla ordenada; las animaciones de entrada y salida son curvas de la transformación
# (opacity, scale, x, y, rotation) en segundos desde el borde del clip, con píxeles de una secuencia de 1920 × 1080.
param([string]$Destino = '')

$ErrorActionPreference = 'Stop'
$inv = [System.Globalization.CultureInfo]::InvariantCulture
$Fuentes = 'rodaje-fuentes@1.0.0'

function K([double]$t, [double]$v, [string]$i = 'linear') { [ordered]@{ t = $t; value = $v; interp = $i } }

function Fuente([string]$familia, [string]$id, [int]$peso, [string[]]$respaldo, [bool]$cursiva = $false) {
    [ordered]@{ family = $familia; weight = $peso; italic = $cursiva; source = "$Fuentes/$id"; fallback = $respaldo }
}

function Anim([double]$d, $curvas) { [ordered]@{ durationSeconds = $d; curves = $curvas } }

# Fundido simple de entrada o de salida.
function FundidoEntra([double]$d, [string]$i = 'easeOut') { Anim $d ([ordered]@{ opacity = @((K 0 0 $i), (K $d 1)) }) }
function FundidoSale([double]$d, [string]$i = 'easeIn') { Anim $d ([ordered]@{ opacity = @((K 0 1 $i), (K $d 0)) }) }

function Estilo([string]$id, [string]$nombre, [string]$descripcion, $fuente, [double]$tam, $resto) {
    $e = [ordered]@{
        format = 'rodaje.textstyle'; version = 1; id = $id; name = $nombre; description = $descripcion
        font = $fuente; size = $tam; reference = [ordered]@{ width = 1920; height = 1080 }
    }
    foreach ($k in $resto.Keys) { $e[$k] = $resto[$k] }
    $e
}

$SansWin = @('Segoe UI', 'Arial')

$estilos = @(
    (Estilo 'titulo-grande' 'Título grande' 'Título de apertura: grande, blanco y con sombra suave; entra creciendo un poco.' `
        (Fuente 'Inter' 'inter' 800 @('Segoe UI Black', 'Segoe UI', 'Arial')) 140 ([ordered]@{
            lineHeight = 1.05; letterSpacing = -2; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            shadow = [ordered]@{ color = '#00000080'; dx = 0; dy = 6; blur = 18 }
            in = Anim 0.6 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.6 1)); scale = @((K 0 0.92 'easeOut'), (K 0.6 1)) })
            out = Anim 0.4 ([ordered]@{ opacity = @((K 0 1 'easeIn'), (K 0.4 0)); scale = @((K 0 1 'easeIn'), (K 0.4 1.04)) })
        })),
    (Estilo 'tercio-inferior' 'Tercio inferior' 'Nombre o cargo sobre una banda oscura, alineado a la izquierda; entra deslizándose.' `
        (Fuente 'Montserrat' 'montserrat' 600 $SansWin) 54 ([ordered]@{
            lineHeight = 1.2; align = 'left'
            fill = [ordered]@{ color = '#FFFFFF' }
            background = [ordered]@{ color = '#1D1D1DD9'; padding = @(32, 16); radius = 6 }
            in = Anim 0.45 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.45 1)); x = @((K 0 -80 'easeOut'), (K 0.45 0)) })
            out = Anim 0.35 ([ordered]@{ opacity = @((K 0 1 'easeIn'), (K 0.35 0)); x = @((K 0 0 'easeIn'), (K 0.35 -40)) })
        })),
    (Estilo 'cita' 'Cita' 'Serif en cursiva, crema y con aire entre líneas; fundido lento.' `
        (Fuente 'Lora' 'lora' 500 @('Georgia', 'Cambria', 'Times New Roman') $true) 72 ([ordered]@{
            lineHeight = 1.35; align = 'center'
            fill = [ordered]@{ color = '#F5EFE6' }
            shadow = [ordered]@{ color = '#00000099'; dx = 0; dy = 3; blur = 10 }
            in = FundidoEntra 0.8 'easeInOut'
            out = FundidoSale 0.6 'easeInOut'
        })),
    (Estilo 'rotulo-condensado' 'Rótulo condensado' 'Condensada, espaciada y con borde fino; sube al entrar.' `
        (Fuente 'Oswald' 'oswald' 600 @('Bahnschrift', 'Arial')) 110 ([ordered]@{
            lineHeight = 1.0; letterSpacing = 4; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            stroke = [ordered]@{ color = '#000000'; width = 3; join = 'miter' }
            in = Anim 0.4 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.4 1)); y = @((K 0 40 'easeOut'), (K 0.4 0)) })
            out = Anim 0.35 ([ordered]@{ opacity = @((K 0 1 'easeIn'), (K 0.35 0)); y = @((K 0 0 'easeIn'), (K 0.35 -30)) })
        })),
    (Estilo 'neon' 'Neón' 'Letras claras con un halo cian, que parpadean al encenderse.' `
        (Fuente 'Montserrat' 'montserrat' 700 $SansWin) 120 ([ordered]@{
            lineHeight = 1.1; letterSpacing = 2; align = 'center'
            fill = [ordered]@{ color = '#E9FEFF' }
            stroke = [ordered]@{ color = '#00C8E0'; width = 2; join = 'round' }
            shadow = [ordered]@{ color = '#00E5FFCC'; dx = 0; dy = 0; blur = 32 }
            in = Anim 0.45 ([ordered]@{ opacity = @((K 0 0 'hold'), (K 0.08 1 'hold'), (K 0.14 0.25 'hold'), (K 0.22 1 'hold'), (K 0.3 0.55), (K 0.45 1)) })
            out = FundidoSale 0.3
        })),
    (Estilo 'manuscrito' 'Manuscrito' 'Letra a mano, cálida, que entra con un pequeño giro.' `
        (Fuente 'Caveat' 'caveat' 600 @('Ink Free', 'Segoe Print', 'Segoe UI')) 110 ([ordered]@{
            lineHeight = 1.1; align = 'center'
            fill = [ordered]@{ color = '#FFF6D5' }
            shadow = [ordered]@{ color = '#00000080'; dx = 2; dy = 4; blur = 6 }
            in = Anim 0.6 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.6 1)); rotation = @((K 0 -4 'easeOut'), (K 0.6 0)); scale = @((K 0 0.9 'easeOut'), (K 0.6 1)) })
            out = FundidoSale 0.4
        })),
    (Estilo 'maquina-de-escribir' 'Máquina de escribir' 'Monoespaciada sobre una caja negra, que aparece de golpe en dos pasos.' `
        (Fuente 'JetBrains Mono' 'jetbrains-mono' 500 @('Consolas', 'Courier New')) 60 ([ordered]@{
            lineHeight = 1.3; align = 'left'
            fill = [ordered]@{ color = '#EDEDED' }
            background = [ordered]@{ color = '#000000B3'; padding = @(24, 14); radius = 0 }
            in = Anim 0.16 ([ordered]@{ opacity = @((K 0 0 'hold'), (K 0.08 0.5 'hold'), (K 0.16 1)) })
            out = Anim 0.16 ([ordered]@{ opacity = @((K 0 1 'hold'), (K 0.08 0.5 'hold'), (K 0.16 0)) })
        })),
    (Estilo 'redondeado' 'Redondeado' 'Redondeada y amable sobre una píldora coral; entra con un rebote.' `
        (Fuente 'Nunito' 'nunito' 800 @('Segoe UI', 'Arial Rounded MT Bold', 'Arial')) 96 ([ordered]@{
            lineHeight = 1.1; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            background = [ordered]@{ color = '#FF7A59F2'; padding = @(44, 18); radius = 60 }
            in = Anim 0.45 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.2 1), (K 0.45 1)); scale = @((K 0 0.6 'easeOut'), (K 0.3 1.08 'easeInOut'), (K 0.45 1)) })
            out = Anim 0.3 ([ordered]@{ opacity = @((K 0 1 'easeIn'), (K 0.3 0)); scale = @((K 0 1 'easeIn'), (K 0.3 0.8)) })
        })),
    (Estilo 'impacto' 'Impacto' 'Display gruesa en amarillo con borde y sombra dura; entra de golpe desde grande.' `
        (Fuente 'Anton' 'anton' 400 @('Impact', 'Arial Black', 'Arial')) 180 ([ordered]@{
            lineHeight = 1.0; letterSpacing = 1; align = 'center'
            fill = [ordered]@{ color = '#FFD400' }
            stroke = [ordered]@{ color = '#111111'; width = 8; join = 'miter' }
            shadow = [ordered]@{ color = '#000000'; dx = 10; dy = 10; blur = 0 }
            in = Anim 0.3 ([ordered]@{ opacity = @((K 0 0), (K 0.1 1), (K 0.3 1)); scale = @((K 0 1.6 'easeOut'), (K 0.3 1)) })
            out = Anim 0.25 ([ordered]@{ opacity = @((K 0 1 'easeIn'), (K 0.25 0)); scale = @((K 0 1 'easeIn'), (K 0.25 1.2)) })
        })),
    (Estilo 'minimal' 'Minimal' 'Fina, muy espaciada y sin adornos; fundido largo.' `
        (Fuente 'Inter' 'inter' 300 @('Segoe UI Light', 'Segoe UI', 'Arial')) 60 ([ordered]@{
            lineHeight = 1.3; letterSpacing = 14; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            in = FundidoEntra 1.0 'easeInOut'
            out = FundidoSale 0.8 'easeInOut'
        })),
    (Estilo 'etiqueta' 'Etiqueta' 'Texto corto en negrita sobre una pastilla naranja, para destacar un dato.' `
        (Fuente 'Inter' 'inter' 700 $SansWin) 44 ([ordered]@{
            lineHeight = 1.15; letterSpacing = 1; align = 'left'
            fill = [ordered]@{ color = '#1D1D1D' }
            background = [ordered]@{ color = '#E8833A'; padding = @(22, 10); radius = 8 }
            in = Anim 0.3 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.3 1)); y = @((K 0 16 'easeOut'), (K 0.3 0)) })
            out = FundidoSale 0.25
        })),
    (Estilo 'subtitulos' 'Subtítulos' 'Subtítulo legible: blanco con borde negro y sombra, fundido muy corto.' `
        (Fuente 'Atkinson Hyperlegible Next' 'atkinson-hyperlegible-next' 600 $SansWin) 52 ([ordered]@{
            lineHeight = 1.25; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            stroke = [ordered]@{ color = '#000000'; width = 4; join = 'round' }
            shadow = [ordered]@{ color = '#000000B3'; dx = 0; dy = 2; blur = 6 }
            in = FundidoEntra 0.12 'linear'
            out = FundidoSale 0.12 'linear'
        })),
    (Estilo 'subtitulos-caja' 'Subtítulos en caja' 'Subtítulo sobre una caja semitransparente, sin animación; cubre latino extendido, griego y cirílico.' `
        (Fuente 'Noto Sans' 'noto-sans' 500 $SansWin) 48 ([ordered]@{
            lineHeight = 1.25; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            background = [ordered]@{ color = '#000000B3'; padding = @(20, 10); radius = 8 }
        })),
    (Estilo 'karaoke-pop' 'Karaoke pop' 'Palabra a palabra: blanco con borde negro y la palabra que suena en amarillo.' `
        (Fuente 'Montserrat' 'montserrat' 800 $SansWin) 72 ([ordered]@{
            lineHeight = 1.15; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            highlight = [ordered]@{ color = '#FFD400' }
            stroke = [ordered]@{ color = '#000000'; width = 5; join = 'round' }
            shadow = [ordered]@{ color = '#00000099'; dx = 0; dy = 4; blur = 8 }
            in = Anim 0.2 ([ordered]@{ opacity = @((K 0 0 'easeOut'), (K 0.2 1)); scale = @((K 0 0.9 'easeOut'), (K 0.2 1)) })
            out = FundidoSale 0.2
        })),
    (Estilo 'karaoke-suave' 'Karaoke suave' 'Palabra a palabra sobre una caja oscura, con la palabra que suena en turquesa.' `
        (Fuente 'Nunito' 'nunito' 800 $SansWin) 64 ([ordered]@{
            lineHeight = 1.2; align = 'center'
            fill = [ordered]@{ color = '#FFFFFF' }
            highlight = [ordered]@{ color = '#4FD1C5' }
            background = [ordered]@{ color = '#00000099'; padding = @(28, 12); radius = 16 }
            in = FundidoEntra 0.2
            out = FundidoSale 0.2
        }))
)

function Json($v, [string]$sangria = '') {
    $mas = $sangria + '  '
    if ($null -eq $v) { return 'null' }
    if ($v -is [bool]) { if ($v) { return 'true' } else { return 'false' } }
    if ($v -is [string]) {
        $s = $v.Replace('\', '\\').Replace('"', '\"')
        return '"' + $s + '"'
    }
    if ($v -is [int] -or $v -is [long] -or $v -is [double] -or $v -is [decimal]) { return ([double]$v).ToString('R', $inv) }
    if ($v -is [System.Collections.IDictionary]) {
        $partes = foreach ($k in $v.Keys) { $mas + '"' + $k + '": ' + (Json $v[$k] $mas) }
        return "{`n" + ($partes -join ",`n") + "`n$sangria}"
    }
    if ($v -is [System.Collections.IEnumerable]) {
        $lista = @($v)
        if ($lista.Count -eq 0) { return '[]' }
        $simples = -not ($lista | Where-Object { $_ -is [System.Collections.IDictionary] })
        if ($simples) { return '[' + (($lista | ForEach-Object { Json $_ $mas }) -join ', ') + ']' }
        $partes = foreach ($x in $lista) { $mas + (Json $x $mas) }
        return "[`n" + ($partes -join ",`n") + "`n$sangria]"
    }
    throw "Tipo sin JSON: $($v.GetType().FullName)"
}

if (-not $Destino) { $Destino = $PSScriptRoot }
$carpeta = Join-Path ([System.IO.Path]::GetFullPath($Destino)) 'estilos'
[System.IO.Directory]::CreateDirectory($carpeta) | Out-Null
$utf8 = New-Object System.Text.UTF8Encoding($false)
foreach ($e in $estilos) {
    [System.IO.File]::WriteAllText((Join-Path $carpeta "$($e.id).json"), (Json $e) + "`n", $utf8)
}
Write-Host "  $($estilos.Count) estilos en $carpeta"
