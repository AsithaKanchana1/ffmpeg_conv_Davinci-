# ffmpeg_conv_Davinci-

## OBS to DaVinci Resolve (Linux Free Version) Workflow Guide

### 1) OBS Recording Settings

In **OBS > Settings > Output > Recording (Advanced Mode)**:

- **Recording Format:** `mkv`
- **Video Encoder:** `QuickSync HEVC` (or `QuickSync H.264`)
- **Audio Encoder:** `PCM` (for example `pcm_s16le` or `32-bit float`)

### 2) Transcoding Command

Convert OBS MKV footage into a DaVinci-friendly DNxHR MOV before import:

```bash
ffmpeg -i input_recording.mkv -map 0 -c:v dnxhd -profile:v dnxhr_sq -c:a pcm_s16le output_editing.mov
```

You can also use the included helper script:

```bash
./convert_to_davinci_mov.sh input_recording.mkv output_editing.mov
```

If output is omitted, the script creates `<input_name>_edit.mov`.

### 3) Fish Shell Automation

Create this function file:

```bash
nvim ~/.config/fish/functions/resolve_convert.fish
```

Paste:

```fish
function resolve_convert -d "Convert OBS MKV to DaVinci Resolve friendly DNxHR MOV"
    if test -z "$argv[1]"
        echo "Usage: resolve_convert <input_file.mkv>"
        return 1
    end

    set input_file $argv[1]
    set base_name (basename $input_file .mkv)
    set output_file "$base_name"_edit.mov

    echo "Transcoding '$input_file' to '$output_file'..."
    ffmpeg -i "$input_file" -map 0 -c:v dnxhd -profile:v dnxhr_sq -c:a pcm_s16le "$output_file"
    echo "Done! Ready for Resolve."
end
```

Usage:

```bash
resolve_convert my_gameplay.mkv
```