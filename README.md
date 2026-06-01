# Jarvis Characters

Repositorio de personajes 2D descargables desde la Tienda de JARVIS AI.

## Estructura

```
jarvis-characters-repo/
├── README.md
├── index.json              ← Metadatos de todos los personajes
└── characters/
    ├── boy1.zip             ← Sprites del personaje "boy1"
    └── girl1.zip            ← Sprites del personaje "girl1"
```

## Formato de cada .zip

Cada zip contiene 5 imágenes PNG dentro de una carpeta con el nombre del personaje:

```
boy1.zip
└── boy1/
    ├── idle.png
    ├── idle_blink.png
    ├── speaking_1.png
    ├── speaking_2.png
    └── thinking.png
```

## index.json

```json
{
  "characters": [
    {
      "id": "boy1",
      "name": "Boy1",
      "description": "Personaje Boy1",
      "preview": "boy1/idle.png",
      "type": "sprite",
      "download_url": "https://github.com/YongllyPM/Jarvis-characters/raw/main/characters/boy1.zip"
    }
  ]
}
```

## Cómo agregar un personaje nuevo

1. Creá una carpeta con los 5 PNGs (mismos nombres)
2. Comprimila a `.zip` (la carpeta adentro debe tener el nombre del personaje)
3. Copiá el `.zip` a `characters/`
4. Agregá su entrada en `index.json`
5. Subí todo al repo `YongllyPM/Jarvis-characters`

## Cómo generar desde JARVIS

Corré `build_characters.py` en la raíz del proyecto JARVIS y subí el contenido de `_character_zips/`.
