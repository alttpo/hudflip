# hudflip
Simple HUD horizontal flip ASM patch for ALTTP JP 1.0 vanilla or derivative ROM

## Screenshots
![alttp-jp-20220524-232332](https://user-images.githubusercontent.com/538152/170369418-c5e923c2-b4eb-453f-8825-c947fc58e76b.png)
![DR-20220525-002314](https://user-images.githubusercontent.com/538152/170369479-f4c8ff96-49bd-4ab0-a00a-8d8a7bbf9b0e.png)
![alttp-jp-20220525-000411](https://user-images.githubusercontent.com/538152/170369506-a6018d4a-1d10-46f2-ae4f-4eeb32ff8759.png)

## How to patch via BPS:
1. Download the latest `hud-hflip.bps` BPS patch from Releases.
2. Apply the BPS patch using your favorite BPS tool to an ALTTP JP 1.0 vanilla or derivative ROM.

## How to patch via `asar`:
**REQUIRES**: [asar](https://github.com/RPGHacker/asar)

Assuming you have a ALTTP JP 1.0 vanilla or derivative ROM (unheadered) named as `alttp-jp-vanilla.sfc`:

```
cp alttp-jp-vanilla.sfc alttp-jp.sfc
asar main.asm alttp-jp.sfc
```

This will produce `alttp-jp.sfc` as output.

## Code
The ASM code to h-flip the HUD lives in free ROM at `$00CF46[0x7A]`. This can be easily extended to do any combination of h-flip and v-flip.

The patch point to `JMP $CF46` to the h-flip routine is the very end of the `NMI_PrepareSprites` routine executed immediately after the `JSL Module_MainRouting` in the main loop.

The ASM code uses free WRAM at `$7EC900[0x180]` to store the h-flipped HUD BG3 tilemap which is eventually DMA'd to VRAM during NMI.

The NMI routine is patched to DMA to BG3 VRAM from `$7EC900` instead of the vanilla `$7EC700` buffer.
