# OBS to DaVinci Resolve (Linux Free Version) Workflow Guide

This guide outlines the optimal workflow for recording video in OBS and preparing it for DaVinci Resolve Free on Linux, bypassing proprietary codec limitations.

## 1. OBS Recording Settings

**In OBS > Settings > Output > Recording (Advanced Mode):**

- **Recording Format:** `mkv` (Crash-safe).
- **Video Encoder:** `QuickSync HEVC` (or `QuickSync H.264`). This ensures smooth recording via your Intel media engine.
- **Audio Encoder:** `PCM` (e.g., `pcm_s16le` or `32-bit float`). _Crucial step to prevent muted audio in Resolve._

## 2. The Transcoding Command

Before importing into DaVinci Resolve, you must convert the compressed QuickSync footage into an edit-friendly intermediate codec (DNxHR) wrapped in a MOV container.

**The Core FFmpeg Command:**

```bash
ffmpeg -i input_recording.mkv -map 0 -c:v dnxhd -profile:v dnxhr_sq -c:a pcm_s16le output_editing.mov
```

## 3. Fish Shell Automation

To automate this process in the fish shell, you create a dedicated function file.

**Step 1:** Create a new file in your fish functions directory:

```bash
nvim ~/.config/fish/functions/resolve_convert.fish
```

**Step 2:** Paste the following fish syntax:

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

**Step 3:** Save the file. Fish will automatically load it.

**Usage:**
Navigate to your recordings directory in Kitty, and run:

```bash
resolve_convert my_gameplay.mkv
```

This will instantly generate `my_gameplay_edit.mov`, fully compliant and ready to be dropped directly into the DaVinci Resolve media pool.
