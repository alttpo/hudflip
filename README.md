# hudflip
Simple HUD horizontal flip ASM patch for ALTTP JP 1.0 ROMs

## How to patch:
Assuming you have a vanilla JP 1.0 ALTTP ROM file (unheadered) named as `alttp-jp-vanilla.sfc`:

```
cp alttp-jp-vanilla.sfc alttp-jp.sfc
asar main.asm alttp-jp.sfc
```

This will produce `alttp-jp.sfc` as output.

## Requirements:
Asar https://github.com/RPGHacker/asar
