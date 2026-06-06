# ffmpeg_conv_Davinci-

Convert QuickSync/SVT output `.mkv` files into a DaVinci Resolve friendly `.mov`.

## Usage

```bash
./convert_to_davinci_mov.sh input.mkv output.mov
```

The script keeps the video stream when possible and remuxes to MOV with an HEVC
`hvc1` tag, while converting audio to PCM for broad Resolve compatibility.